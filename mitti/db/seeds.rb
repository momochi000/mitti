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

    FactoryBot.create(
      :rule,
      name: 'Attic Vent',
      written_rule: "Ensure all vents, chimneys, and screens can withstand embers (i.e., should be ember-rated)",
      functional_rule: nil,
      example_mitigation: 'Add Vents',
      creator: applied_scientist
    )
  end
end
