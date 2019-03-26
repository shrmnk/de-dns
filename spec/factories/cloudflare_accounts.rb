require 'securerandom'

FactoryBot.define do
  factory :cloudflare_account do

    user

    email { FFaker::Internet.email }
    key { SecureRandom.hex }

    trait :invalid do
      email { nil }
      key { nil }
    end
    
  end
end
