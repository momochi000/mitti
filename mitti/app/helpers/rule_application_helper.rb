module RuleApplicationHelper
  # Pretty observation results is called on results returned from RuleApplication.apply_all_rules.
  # observation_results takes the form of
  # [
  #   { rule: Rule,
  #     is_vulnerable?: boolean,
  #     mitigations?: {
  #       bridge_mitigations: [],
  #       full_mitigations: []
  #     }
  #   }
  # ]
  def pretty_observation_results(observation_results)
    #observation_results.map { |r| r.merge({rule: r[:rule].name}) }
    observation_results.map { |r| pretty_rule_result(r) }
  end

  def pretty_rule_result(rule_result)
    return '' if rule_result.blank?
    rule_result.merge({rule: rule_result[:rule].name})
  end
end
