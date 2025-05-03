FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }

    factory :admin, class: 'Users::Admin'
    factory :applied_scientist, class: 'Users::AppliedScientist'
    factory :underwriter, class: 'Users::Underwriter'
  end
end
