FactoryBot.define do
  factory :rule do
    name { "MyString" }
    written_rule { "MyText" }
    functional_rule { "MyText" }
    example_mitigation { "MyText" }
  end
end
