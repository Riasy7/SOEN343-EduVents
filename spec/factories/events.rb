FactoryBot.define do
  factory :event do
    name { "MyString" }
    description { "MyText" }
    event_type { "MyString" }
    location { "MyString" }
    organizer_id { create(:organizer).id }
    published_at { "2025-03-12 16:52:13" }

    factory :competition_event do
      event_type { "competition" }
    end
  end
end
