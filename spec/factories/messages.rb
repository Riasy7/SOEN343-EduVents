FactoryBot.define do
  factory :message do
    content { "MyText" }
    sender_id { 1 }
    receiver_id { 1 }
    event_id { 1 }
  end
end
