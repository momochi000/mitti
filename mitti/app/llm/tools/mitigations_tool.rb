module Tools
  class MitigationsTool
    extend Langchain::ToolDefinition

    define_function :determine_bridge_mitigations, description: "BridgeMitigationTool: If a property is vulnerable to a provided vulnerability rule, determine partial mitigations which would reduce the risk. Given some observations about the property, we want to determine if there are some partial mitigations which could reduce the risk to the vulnerability defined by the given rule." do

      property :bridge_mitigations, type: "array", description: "A list of possible bridge mitigations for the given vulnerability. A bridge mitigation is a way to partially address the vulnerability in question. It modifies the property to reduce risk of the vulnerability given the observations of the property. If no bridge mitigations are possible return an empty array." do
        item type: "string", description: "A bridge mitigation"
      end
    end

    define_function :determine_full_mitigations, description: "FullMitigationTool: If a property is vulnerable to a provided vulnerability rule, determine full mitigations which would essentially eliminate the risk. Given some observations about the property, we want to determine if there are some mitigations which could prevent the risk to the property defined by the given vulnerability rule." do

      property :full_mitigations, type: "array", description: "A list of possible full mitigations for the given vulnerability. A full mitigation is a way to completely address the vulnerability in question. It modifies the property to virtually eliminate risk of the vulnerability given the observations of the property. If no full mitigations are possible, return an empty array." do
        item type: "string", description: "A full mitigation"
      end
    end

    def determine_bridge_mitigations(bridge_mitigations)
      bridge_mitigations
    end

    def determine_full_mitigations(full_mitigations)
      full_mitigations
    end
  end
end
