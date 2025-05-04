module ObservationsHelper
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
    observation_results.map { |r| r.merge({rule: r[:rule].name}) }
  end
end
