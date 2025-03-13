FactoryBot.define do
  factory :event do
    name { "MyString" }
    description { "MyText" }
    event_type { "MyString" }
    location { "MyString" }
    organizer_id { 1 }
    published_at { "2025-03-12 16:52:13" }
  end
end
