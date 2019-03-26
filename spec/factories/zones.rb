require 'securerandom'

FactoryBot.define do
  factory :zone do
    cloudflare_account

    name { "#{FFaker::Internet.domain_word}.lvh.me" }
    identifier { SecureRandom.hex }

    trait :invalid do
      name { nil }
      identifier { nil }
    end
    
  end
end
