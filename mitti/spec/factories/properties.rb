FactoryBot.define do
  factory :property do
    address { "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}"}
  end
end
