FactoryBot.define do
  factory :location do
    name { "SGW Campus" }
    address1 { "1455 De Maisonneuve Blvd. W." }
    address2 { "Suite 203" }
    city { "Montreal" }
    state { "QC" }
    country { "CANADA" }
    postal_code { "H3G 1M8" }
    association :organization
  end
end