FactoryBot.define do
  factory :venue do
    name { "H - Sir George Williams University Alumni Auditorium (H-110)" }
    max_capacity { 692 }
    price_per_seat { 10.0 }
    location_id { create(:location).id }
  end
end
