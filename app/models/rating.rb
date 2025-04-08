class Rating < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'AttendeeUser'

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :attendee_id, uniqueness: { scope: :event_id, message: "has already rated this event" }
end