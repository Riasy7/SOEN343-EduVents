# made a factory with realistic data for the orginizaiton model meow
FactoryBot.define do
  factory :organization do
    name { "Concordia University" }
    website { "https://www.concordia.ca" }
    phone { "+1234567890" }

    # was having issues with the organization and location specs so i added this to ensure theres always at least one location
    after(:build) do |organization|
      organization.locations << build(:location, organization: organization)
    end
  end
end