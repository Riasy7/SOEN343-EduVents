# made a factory with realistic data for the orginizaiton model meow
FactoryBot.define do
  factory :organization do
    name { "Concordia University" }
    website { "https://www.concordia.ca" }
    phone { "+1234567890" }
  end
end