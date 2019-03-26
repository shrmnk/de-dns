FactoryBot.define do
  factory :user do

    email { FFaker::Internet.email }

    trait :invalid do
      email { nil }
    end

  end
end
