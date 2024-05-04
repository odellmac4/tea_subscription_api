FactoryBot.define do
  factory :tea do
    title { Faker::Food.ingredient + "tea" }
    description { Faker::Lorem.sentence }
    temperature { Faker::Number.within(range: 75..95)  }
    brew_time { Faker::Number.within(range: 60..120)  }
  end
end
