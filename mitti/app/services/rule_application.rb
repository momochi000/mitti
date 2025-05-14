module RuleApplication
  extend self

  def apply_rule(rule, observation)
    is_vulnerable = RuleApplication.detect_vulnerability_consensus(rule, observation)

    if is_vulnerable
      mitigations = RuleApplication.determine_mitigations(rule, observation)
      {rule: rule, mitigations: mitigations, is_vulnerable: is_vulnerable}
    else
      {rule: rule, is_vulnerable: is_vulnerable}
    end
  end

  def apply_all_rules(observation, historical: false)
    Parallel.map(Rule.all, in_threads: 8) do |curr_rule|
      if historical
        curr_rule = curr_rule.paper_trail.version_at(observation.observed_at)
        next if curr_rule.blank?
      end
      apply_rule(curr_rule, observation)
    end.compact
  end

  def detect_vulnerability(rule, observation)
    messages = [
      { role: 'system', content: detect_vulnerability_prompt },
      { role: 'user', content: detect_vulnerability_instruction(rule, observation) }
    ]

    response = llm.chat(
      messages: messages,
      temperature: 0.0,
      tools: Tools::VulnerabilityTool.function_schemas.to_openai_format,
      tool_choice: {"function" => {"name" => "tools_vulnerability_tool__detect_vulnerability"}, "type" => "function"}
    )
    get_vulnerability_tool_call(response)
  end

  def detect_vulnerability_consensus(rule, observation)
    messages = [
      { role: 'system', content: detect_vulnerability_prompt },
      { role: 'user', content: detect_vulnerability_instruction(rule, observation) }
    ]

    response = llm.chat(
      messages: messages,
      model: 'o3-mini',
      n: 5,
      tools: Tools::VulnerabilityTool.function_schemas.to_openai_format,
      tool_choice: {"function" => {"name" => "tools_vulnerability_tool__detect_vulnerability"}, "type" => "function"}
    )
    get_vulnerability_tool_call_consensus(response)
  end

  def determine_mitigations(rule, observation)
    messages = [
      { role: 'system', content: determine_mitigations_prompt },
      { role: 'user', content: determine_mitigations_instruction(rule, observation) }
    ]

    response = llm.chat(
      messages: messages,
      temperature: 0.0,
      tools: Tools::MitigationsTool.function_schemas.to_openai_format,
      tool_choice: 'auto'
      #tool_choice: [
      #  {"function" => {"name" => "tools_mitigations_tool__determine_bridge_mitigations"}, "type" => "function"},
      #  {"function" => {"name" => "tools_mitigations_tool__determine_full_mitigations"}, "type" => "function"}
      #]
    )
    get_mitigation_tool_call(response)
  end

  #private

  def llm
    Rails.application.config.llm
  end

  def detect_vulnerability_prompt
    "You are a property assessor attempting to determine if the property in question, based on the observations json provided, is vulnerable to the given vulnerability rule. Use the example mitigations and your significant industry experience to guide your judgement."
  end

  def detect_vulnerability_instruction(rule, observation)
    <<-PROMPT
    I've examined #{observation.property.present? ? ("the property at" + observation.property.address) : 'a property'}. Here is what I've noted:
    <PropertyObservations>
    #{observation.content}
    </PropertyObservations>

    Given the following rule:
    <PropertyVulnerabilityRule>
    #{rule_prompt(rule)}
    </PropertyVulnerabilityRule>

    Please determine if the property is vulnerable or at-risk to the given vulnerability rule.
    PROMPT
  end

  def determine_mitigations_prompt
    "You are a property assessor attempting to determine if the property in question, based on the observations json provided, can be hardened or protected against the given vulnerability rule. Use any example mitigations given and your extensive knowledge and experience of property risk assessment to guide your judgement on ways the property can be modified or improved to reduce or remove the risk of this vulnerability. Try to determine as many both partial and full mitigations as possible if possible. It is also possible that no mitigations are possible."
  end

  def determine_mitigations_instruction(rule, observation)
    <<-PROMPT
    I've examined the property at #{observation.property.present? ? ("the property at" + observation.property.address) : 'a property'}. Here is what I've noted:
    <PropertyObservations>
    #{observation.content}
    </PropertyObservations>

    Given the following rule:
    <PropertyVulnerabilityRule>
    #{rule_prompt(rule)}
    </PropertyVulnerabilityRule>

    From the observations, determine if there are any partial (bridge mitigations) or complete (full mitigations) that can be done to the property to reduce or elminate the risks identified in the vulnerability rule.
    PROMPT
  end

  def rule_prompt(rule)
    rule_text = "Rule name: #{rule.name}.\nRule explanation: #{rule.written_rule}."
    if rule.functional_rule.present? && !(rule.functional_rule =~ /same/i)
      rule_text += "\n\nRule definition(s): \n #{rule.functional_rule}"
    end
    rule_text += "\n\nExample mitigations: #{rule.example_mitigation}"
  end

  def get_vulnerability_tool_call(response)
    tool_calls = response.tool_calls
    Rails.logger.debug(response.raw_response)
    if tool_calls.blank?
      Rails.logger.error("Tool call for vulnerability check returned nothing --> #{response.raw_response}")
      return false
    end

    if tool_calls.length > 1
      #Rails.logger.error("Tool call for vulnerability check returned more than one tool call ---> #{messages}")
      raise Exception("Tool call for vulnerability check returned more than one tool call ---> #{messages}")
    end

    JSON.parse(tool_calls.first['function']['arguments'])['is_vulnerable']
  end

  def get_vulnerability_tool_call_consensus(response)
    tool_calls = response.raw_response['choices']

    Rails.logger.debug(response.raw_response)
    if tool_calls.blank?
      Rails.logger.error("Tool call for vulnerability check returned nothing --> #{response.raw_response}")
      return false
    end

    results = tool_calls
      .map{|c| c['message']['tool_calls'][0]['function']['arguments']}
      .map{|a| JSON.parse(a)['is_vulnerable']}

    results.count(true) > results.count(false) ? true : false
  end

  def get_mitigation_tool_call(response)
    tool_calls = response.tool_calls
    Rails.logger.debug(response.raw_response)
    if tool_calls.blank?
      Rails.logger.error("Tool call for mitigation check returned nothing --> #{messages}")
    end

    output = {}
    tool_calls.map do |tool_call|
      case tool_call['function']['name']
      when 'tools_mitigations_tool__determine_full_mitigations'
        output[:full_mitigations] = JSON.parse(tool_call['function']['arguments'])['full_mitigations']
      when 'tools_mitigations_tool__determine_bridge_mitigations'
        output[:bridge_mitigations] = JSON.parse(tool_call['function']['arguments'])['bridge_mitigations']
      else
        Rails.logger.error("Tool call for mitigation check returned unexpected function call")
      end
    end

    output
  end
end
