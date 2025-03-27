FactoryBot.define do
  factory :payment do
    user { nil }
    event { nil }
    amount { "9.99" }
    currency { "MyString" }
    status { "MyString" }
    stripe_payment_intent_id { "MyString" }
    stripe_charge_id { "MyString" }
  end
end
