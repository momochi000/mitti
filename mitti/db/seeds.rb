# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#

namespace :strawman do
  desc 'Basic seed to set up simple database state for testing in development'
  task strawman: :environment do
    # create basic user types
    admin = FactoryBot.create(:admin, email: 'admin@user.com', password: '123456')
    underwriter = FactoryBot.create(:admin, email: 'underwriter@user.com', password: '123456')
    applied_scientist = FactoryBot.create(:admin, email: 'appliedscientist@user.com', password: '123456')

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


    property = FactoryBot.create(:property)
    observation = FactoryBot.create(:observation, property: property, observed_at: Time.now, content:
'{
  "Attic Vent has Screens": "True / False",
  "Roof Type": "Class A / Class B / Class C",
  "Window Type": "Single / Double / Tempered Glass",
  "Wildfire Risk Category": "A / B / C / D",
  "Vegetation": [
    {
      "Type": "Tree / Shrub / Grass",
      "Distance to Window": "(in feet)"
    }
  ]
}')
  end
end
