FactoryBot.define do
  factory :venue do
    name { "MyString" }
    max_capacity { 1 }
    price_per_seat { 1.5 }
  end
end
