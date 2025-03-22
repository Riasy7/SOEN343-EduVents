FactoryBot.define do
  factory :event_registration do
    event { create(:competition_event) }
    attendee { create(:attendee_listener_user) }
  end
end
