class EventRegistration < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'AttendeeUser'

  validates :role, presence: :true
  validates :role, inclusion: { in: %[listener speaker] }
  validate :only_speaker_attendee_can_register_as_speaker

  private

  def only_speaker_attendee_can_register_as_speaker
    if role == "speaker"
      unless AttendeeUser.exists?(id: attendee_id, attendee_type: "speaker")
        errors.add(:attendee_id, "must correspond to a valid speaker attendee")
      end
    end
  end
end
