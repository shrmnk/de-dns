FactoryBot.define do
  factory :hostname do
    zone

    name { "abc.#{zone.name}" }
    a { "127.0.0.1" }
    aaaa { "::1" }
    mx { "exchange.com" }

    trait :invalid do
      name { nil }
      a { nil }
    end
  end
end
