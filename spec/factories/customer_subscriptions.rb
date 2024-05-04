FactoryBot.define do
  factory :customer_subscription do
    status { "MyString" }
    customer { nil }
    subscription { nil }
    tea { nil }
  end
end
