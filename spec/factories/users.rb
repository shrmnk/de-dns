FactoryBot.define do
  factory :user do

    email { FFaker::Internet.email }
    password { '123123123' }

    trait :invalid do
      email { nil }
    end

  end
end
