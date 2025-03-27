class EventRegistration < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'AttendeeUser'

  validates :role, presence: true
  validates :role, inclusion: { in: %w[listener speaker] }
  validates :attendee_id, uniqueness: { scope: :event_id, message: "is already registered for this event" }

  validate :only_speaker_attendee_can_register_as_speaker

  private

  # Ensure only speaker attendees can register as speakers
  def only_speaker_attendee_can_register_as_speaker
    if role == "speaker" && !AttendeeUser.exists?(id: attendee_id, attendee_type: "speaker")
      errors.add(:attendee_id, "must correspond to a valid speaker attendee")
    end
  end
end