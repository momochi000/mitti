namespace :seed do
  desc 'Basic seed to set up simple database state for testing in development'
  task strawman: :environment do
    # create basic user types
    admin = FactoryBot.create(:admin, email: 'admin@user.com', password: '123456')
    underwriter = FactoryBot.create(:underwriter, email: 'underwriter@user.com', password: '123456')
    applied_scientist = FactoryBot.create(:applied_scientist, email: 'appliedscientist@user.com', password: '123456')

    FactoryBot.create(:rule,
      name: 'Attic Vent',
      written_rule: "Ensure all vents, chimneys, and screens can withstand embers (i.e., should be ember-rated)",
      functional_rule: nil,
      example_mitigation: 'Add Vents',
      creator: applied_scientist
    )

    FactoryBot.create(:rule,
      name: 'Roof',
      written_rule: "Ensure roof is Class A by assembly, free of gaps, and well maintained. In low wildfire areas(Category A) roofs can be Class B or Class A",
      functional_rule: nil,
      example_mitigation: 'No mitigation possible',
      creator: applied_scientist
    )

    FactoryBot.create(:rule,
      name: 'Windows',
      written_rule: "Ensure windows can withstand heat exposure of surrounding combustibles and vegetation burning",
      functional_rule: "* Safe Window Distance for Tempered Glass from Trees is 30 feet
* Window Types
    - Multiply safe Distance by 3 for single pane windows

    - Multiply safe Distance by 2 for double pane windows
* Vegetation Types
    - Divide safe Distance by 2 for shrubs
    - Divide Safe Distance by 3 for grass.",
      example_mitigation: "**Full Mitigations**
* Remove Vegetation
* Replace window with Tempered Glass

**Bridge Mitigations**
* Apply a Film to windows which decreases minimum safe distance by 20%
* Apply flame retardants to shrubs that decrease minimum safe distance by 25%
* Prune trees to a safe height decreases safe distance by 50%",
      creator: applied_scientist
    )

    FactoryBot.create(
      :rule,
      name: "Exterior Siding.",
      written_rule: "Ensure all exterior siding components are rated for high heat exposure and do not contribute to rapid fire spread.",
      functional_rule: "
       * Siding Material Types:
         - Fiber cement: Meets standard
         - Vinyl: Requires additional treatment
       * Installation standards:
         - Overlap must be at least 2 inches",
      example_mitigation: "**Full Mitigations**
      * Replace vinyl siding with fiber cement
      **Bridge Mitigations**
      * Apply fire-resistant coating to existing vinyl"
    )

    FactoryBot.create(
      :rule,
      name: "Deck and Balcony Structures.",
      written_rule: "Ensure wooden decks and balconies have proper maintenance and use fire-retardant materials, avoiding accumulation of combustible debris.",
      functional_rule: "
      * Material considerations:
        - Pressure-treated wood is preferred over untreated wood
      * Maintenance standards:
        - Clean debris at least quarterly",
      example_mitigation: "**Full Mitigations**
      * Replace untreated wood with fire-retardant treated wood
      **Bridge Mitigations**
      * Regular debris removal and application of flame retardants"
    )

    FactoryBot.create(
      :rule,
      name: "Garage Doors.",
      written_rule: "Ensure garage doors are made of non-combustible or fire-resistant materials and are properly sealed to prevent ember entry.",
      example_mitigation: "**Full Mitigations**
      * Replace with metal or composite doors designed for high temperatures
      **Bridge Mitigations**
      * Install additional weather stripping along the frame"
    )

    FactoryBot.create(
      :rule,
      name: "Yard Vegetation Clearance.",
      written_rule: "Ensure landscaping does not include vegetation that can easily ignite via ember attack; maintain safe distances.",
      functional_rule: "
       * Clearance distances:
         - Minimum of 10 feet clearance from the structure for large trees
         - Shrubs must be kept at least 5 feet away",
      example_mitigation: "**Full Mitigations**
      * Replace flammable vegetation with fire-resistant species
      **Bridge Mitigations**
      * Prune vegetation to maintain clearance and reduce fuel load"
    )

    FactoryBot.create(
      :rule,
      name: "Fire Sprinkler Systems.",
      written_rule: "Ensure automatic fire sprinkler systems are installed in vulnerable zones to slow or prevent the spread of fire.",
      functional_rule: "* System specifications:
         - Minimum coverage: entire exterior perimeter
         - Activation temperature: below 165°F",
      example_mitigation: "**Full Mitigations**
      * Install and maintain a certified fire sprinkler system
      **Bridge Mitigations**
      * Implement periodic system checks and manual activation procedures"
    )

    FactoryBot.create(
      :rule,
      name: "Exterior Paint.",
      written_rule: "Ensure all exterior paints are fire-retardant and do not contribute to flame propagation.",
      functional_rule: "
       * Paint classifications:
         - Class A paints: Highly fire-resistant
         - Class B paints: Requires additional treatment",
      example_mitigation: "**Full Mitigations**
      * Repaint with Class A fire-retardant paint
      **Bridge Mitigations**
      * Apply supplemental fire retardant additives to existing paint"
    )

    FactoryBot.create(
      :rule,
      name: "Attic Insulation.",
      written_rule: "Ensure attic insulation materials are non-combustible and installed with proper separation from heat sources.",
      functional_rule: "
       * Insulation materials:
         - Mineral wool: Non-combustible
         - Fiberglass: Requires proper installation and clearance",
      example_mitigation: "**Full Mitigations**
      * Replace combustible insulation with mineral wool
      **Bridge Mitigations**
      * Install heat barriers between insulation and roof"
    )

    FactoryBot.create(
      :rule,
      name: "Pool Equipment Housings.",
      written_rule: "Ensure pool equipment housings are non-combustible and well ventilated to prevent heat buildup near flammable pool chemicals.",
      functional_rule: "
       * Housing materials:
         - Metal housings preferred over plastic
       * Ventilation standards:
         - Minimum of 2 vents per housing unit",
      example_mitigation: "**Full Mitigations**
      * Upgrade housings to metal and add additional ventilation
      **Bridge Mitigations**
      * Retrofit existing housings with fire-resistant panels and vents"
    )

    FactoryBot.create(
      :rule,
      name: "Solar Panel Mounts.",
      written_rule: "Ensure solar panel mounts do not create ignition points by using materials that are heat resistant and properly insulated.",
      functional_rule: "
       * Mounting materials:
         - Stainless steel or composite materials recommended
       * Installation standards:
         - Secure attachments with no loose parts",
      example_mitigation: "**Full Mitigations**
      * Replace mounts with certified heat-resistant models
      **Bridge Mitigations**
      * Retrofit existing mounts with additional fire-resistant insulation"
    )

    FactoryBot.create(
      :rule,
      name: "Exterior Fencing.",
      written_rule: "Ensure fences adjacent to structures are constructed with non-combustible materials and maintain adequate clearance from the building.",
      functional_rule: "
       * Fence types:
         - Metal fences: Preferred
         - Wood fences: Require additional treatments
       * Clearance requirements:
         - Maintain minimum gap of 2 feet from structures",
      example_mitigation: "**Full Mitigations**
      * Replace wood fences with metal alternatives
      **Bridge Mitigations**
      * Treat wood fences with a fire-retardant coating and increase clearance"
    )

    FactoryBot.create(
      :rule,
      name: "Concrete Walkways and Patios.",
      written_rule: "Ensure walkways and patios are designed to prevent fire propagation by minimizing combustible material accumulation and providing proper drainage.",
      functional_rule: "
       * Surface condition:
         - Must be free of accumulated debris or vegetation
       * Drainage parameters:
         - Designed to avoid pooling water that could hide combustibles",
      example_mitigation: "**Full Mitigations**
      * Replace porous materials with high-density concrete
      **Bridge Mitigations**
      * Perform routine cleaning and seal surfaces against debris"
    )

    FactoryBot.create(
      :rule,
      name: "Metal Fencing and Barriers.",
      written_rule: "Ensure metal barriers and fences are free of rust and structural weaknesses, which could compromise fire separation integrity.",
      functional_rule: "
       * Corrosion resistance:
         - Use galvanized or stainless steel materials
       * Structural integrity:
         - Inspect biannually for signs of wear",
      example_mitigation: "**Full Mitigations**
      * Replace corroded sections with high-grade metal
      **Bridge Mitigations**
      * Apply rust inhibitors and repair minor damages"
    )

    FactoryBot.create(
      :rule,
      name: "Garage Ventilation.",
      written_rule: "Ensure that garage ventilation systems are positioned away from ignition sources, serviced regularly, and that combustible items are kept at a safe distance.",
      example_mitigation: "**Bridge Mitigations**:
      * Install additional smoke detectors in the garage.
      * Reroute ventilation ducts away from areas with high ignition risk.
      **Full Mitigations**:
      * Upgrade the ventilation system to a certified fire-resistant model.
      * Clear and permanently remove combustibles from immediate vicinity."
    )

#Rule name: Exterior Deck.
#Rule explanation: Ensure that decks use fire-resistant materials, maintain proper clearances from combustible vegetation, and have guardrails meeting safety standards.
#Example mitigations: Replace wood with composite materials; increase surrounding clear zone.

#Rule name: Gas Piping.
#Rule explanation: Ensure gas piping is installed per code with adequate clearance from ignition sources and potential impact areas.
#Example mitigations: Reroute piping; add heat shield or insulation.

#Rule name: Sprinkler System.
#Rule explanation: Verify that an operational sprinkler system is in place across all relevant property areas, including attics and exterior zones.
#Example mitigations: Install sprinklers in uncovered areas; repair faulty sprinkler lines.

#Rule name: Fire-Resistant Siding.
#Rule explanation: Ensure siding materials are rated for fire resistance, properly sealed, and maintained to prevent rapid flame spread.
#Example mitigations: Replace degraded siding with Class A rated materials.

#Rule name: Fence Clearance.
#Rule explanation: Ensure fences near property boundaries are constructed with non-combustible materials and are located at a safe distance from trees and dry vegetation.
#Example mitigations: Relocate or rebuild fence; trim encroaching vegetation.

#Rule name: Emergency Exits.
#Rule explanation: Confirm that all emergency exits are unobstructed, properly marked, and compliant with evacuation route requirements.
#Example mitigations: Remove obstructions; update exit signage.
#
#Rule name: Fire Doors.
#Rule explanation: Inspect that all fire doors are certified, self-closing, and capable of withstanding specified heat exposures for the required period.
#Example mitigations: Replace non-compliant doors; adjust door closers.
#
#Rule name: Chimney Draft.
#Rule explanation: Ensure chimneys maintain proper draft, are free of soot and creosote buildup, and are equipped with spark arrestors.
#Example mitigations: Schedule regular cleanings; install draft regulators.
#
#Rule name: Basement Egress.
#Rule explanation: Verify the presence of adequate egress points from basements, ensuring they meet size and accessibility criteria.
#Example mitigations: Install compliant egress windows or external exit doors.
#
#Rule name: Electrical Wiring.
#Rule explanation: Ensure that electrical wiring is upgraded, insulated properly, and routed away from combustible structures.
#Example mitigations: Replace outdated wiring; install protective conduits.
#
#Rule name: Roof Gutters.
#Rule explanation: Ensure roof gutters are designed to prevent ember accumulation, remain free of debris, and allow proper water drainage.
#Example mitigations: Regularly clean gutters; install ember guards.
#
#Rule name: Landscaping Clearance.
#Rule explanation: Maintain a defensible space around structures by ensuring that trees, shrubs, and other vegetation are kept at specified safe distances.
#Example mitigations: Trim or remove overgrown vegetation; implement fire-resistant landscaping.

#
#Rule name: Kitchen Hood Systems.
#Rule explanation: Ensure that kitchen hood systems are maintained, cleaned frequently, and incorporate fire suppression mechanisms for timely spark detection.
#Bridge Mitigations:
#* Establish and document a regular cleaning schedule.
#* Apply fire retardant coatings to filters.
#Full Mitigations:
#* Replace existing hood systems with models that meet enhanced fire safety standards.
#* Install integrated fire suppression units to automatically activate during a fire.
#
#Rule name: Fireplace Guard.
#Rule explanation: Confirm that fireplace enclosures have flame-retardant guards and adequate clearance to prevent ember spread to surrounding combustible materials.
#Bridge Mitigations:
#* Install temporary flame deflectors during high-risk periods.
#* Regularly inspect and maintain existing screens.
#Full Mitigations:
#* Replace existing screens with certified, permanently installed fire guards.
#* Upgrade the fireplace setup to a fully enclosed, fire-rated system.
#
#Rule name: Solar Panel Safety.
#Rule explanation: Ensure that solar panel installations incorporate fire-resistant materials, proper clearance from flammable structures, and emergency shutdown features.
#Bridge Mitigations:
#* Apply external fire retardant coatings to solar panel frames.
#* Increase the recommended clearance distances around solar arrays.
#Full Mitigations:
#* Replace old panels with fire-rated models.
#* Install automatic disconnect systems that trigger during emergency fire conditions.
#
#Rule name: Sidewalk Clearances.
#Rule explanation: Verify that sidewalks adjacent to buildings are free of obstructions, maintain safe distances from vegetation, and prevent ember accumulation.
#Bridge Mitigations:
#* Trim or relocate trees and shrubs that encroach on safety clearances.
#* Remove temporary flammable landscaping elements near the sidewalk.
#Full Mitigations:
#* Repave sidewalks using non-combustible materials.
#* Permanently redesign landscape to include fire-resistant barriers and adequate clearance zones.


    property = FactoryBot.create(:property)

    example_observation_jsons.each do |example_observation_content|
      FactoryBot.create(
        :observation, 
        property: FactoryBot.create(:property), 
        observed_at: Time.now, 
        content: JSON.dump(example_observation_content))
    end
  end
end

def example_observation_jsons
  [
    {
      "Property Location": "Urban",
      "Attic Vent has Screens": "True",
      "Roof Type": "Class A",
      "Window Type": "Tempered Glass",
      "Wildfire Risk Category": "A",
      "Vegetation": [],
      "Garage Ventilation": "Upgraded fire-resistant model",
      "Sidewalk Clearance": "Clear"
    },
    {
      "Property Location": "Suburban",
      "Attic Vent has Screens": "False",
      "Roof Type": "Class B",
      "Window Type": "Double",
      "Wildfire Risk Category": "B",
      "Vegetation": [
        {
          "Type": "Tree",
          "Distance to Window": "40 feet"
        }
      ],
      "Garage Ventilation": "Standard; review recommended",
      "Kitchen Hood Condition": "Clean with scheduled maintenance"
    },
    {
      "Property Location": "Rural",
      "Attic Vent has Screens": "True",
      "Roof Type": "Class C",
      "Window Type": "Single",
      "Wildfire Risk Category": "D",
      "Vegetation": [
        {
          "Type": "Shrub",
          "Distance to Window": "15 feet"
        },
        {
          "Type": "Tree",
          "Distance to Window": "25 feet"
        }
      ],
      "Kitchen Hood Condition": "Old model with dirty filters",
      "Landscape Maintenance": "Vegetation overgrown"
    },
    {
      "Property Location": "Rural",
      "Attic Vent has Screens": "False",
      "Roof Type": "Class B",
      "Window Type": "Double",
      "Wildfire Risk Category": "C",
      "Vegetation": [
        {
          "Type": "Grass",
          "Distance to Window": "10 feet"
        }
      ],
      "Solar Panel Status": "Installed; frames non-fire-resistant",
      "Sidewalk Clearance": "N/A"
    },
    {
      "Property Location": "Suburban",
      "Attic Vent has Screens": "True",
      "Roof Type": "Class A",
      "Window Type": "Tempered Glass",
      "Wildfire Risk Category": "B",
      "Vegetation": [
        {
          "Type": "Shrub",
          "Distance to Window": "20 feet"
        }
      ],
      "Kitchen Hood Condition": "Functioning with fire suppression; cosmetic updates needed"
    },
#    {
#      "Property Location": "Urban",
#      "Attic Vent has Screens": "True",
#      "Roof Type": "Class A",
#      "Window Type": "Tempered Glass",
#      "Wildfire Risk Category": "A",
#      "Vegetation": [],
#      "Chimney Condition": "Soot accumulation detected; spark arrestor missing"
#    },
    {
      "Property Location": "Rural",
      "Attic Vent has Screens": "False",
      "Roof Type": "Class B",
      "Window Type": "Double",
      "Wildfire Risk Category": "C",
      "Vegetation": [
        {
          "Type": "Tree",
          "Distance to Window": "35 feet"
        }
      ],
      "Fireplace Guard": "Installed but not flame-retardant",
      "Landscape Maintenance": "Partial vegetation clearing observed"
    },
    {
      "Property Location": "Urban",
      "Attic Vent has Screens": "True",
      "Roof Type": "Class A",
      "Window Type": "Tempered Glass",
      "Wildfire Risk Category": "A",
      "Vegetation": [
        {
          "Type": "Grass",
          "Distance to Window": "25 feet"
        }
      ],
      "Sidewalk Clearance": "Adequate",
      "Landscape Maintenance": "Routine trimming observed"
    },
    {
      "Property Location": "Suburban",
      "Attic Vent has Screens": "True",
      "Roof Type": "Class B",
      "Window Type": "Double",
      "Wildfire Risk Category": "B",
      "Vegetation": [
        {
          "Type": "Tree",
          "Distance to Window": "50 feet"
        }
      ],
      "Roof Gutters": "Debris accumulation observed; cleaning needed"
    },
    {
      "Property Location": "Rural",
      "Attic Vent has Screens": "False",
      "Roof Type": "Class C",
      "Window Type": "Single",
      "Wildfire Risk Category": "D",
      "Vegetation": [
        {
          "Type": "Shrub",
          "Distance to Window": "12 feet"
        }
      ],
      "Garage Ventilation": "Obstructed by surrounding vegetation",
      "Sidewalk Clearance": "Not applicable"
    },
    {
      "Property Location": "Suburban",
      "Attic Vent has Screens": "True",
      "Roof Type": "Class A",
      "Window Type": "Tempered Glass",
      "Wildfire Risk Category": "A",
      "Vegetation": [
        {
          "Type": "Tree",
          "Distance to Window": "45 feet"
        },
        {
          "Type": "Shrub",
          "Distance to Window": "30 feet"
        }
      ],
      "Kitchen Hood Condition": "Regularly maintained",
      "Garage Ventilation": "Upgraded fire-resistant system installed"
    },
    {
      "Property Location": "Urban High-rise",
      "Attic Vent has Screens": "True",
      "Roof Type": "Class A",
      "Window Type": "Tempered Glass",
      "Wildfire Risk Category": "A",
      "Vegetation": [],
      "Chimney Condition": "Well maintained",
      "Fireplace Guard": "Not applicable",
      "Solar Panel Status": "Roof-mounted panels meet fire safety standards"
    }
  ]
end
