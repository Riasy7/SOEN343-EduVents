class AttendeeUser < User
  has_many :event_registrations, foreign_key: :attendee_id
  has_many :events, through: :event_registrations

  validates :attendee_type, presence: true, inclusion: { in: %(speaker listener) }

  def get_registration_for_event(event_id)
    event_registrations.find_by(event_id: event_id)&.id
  end

  def registered_for_event?(event_id)
    EventRegistration.exists?(attendee_id: self.id, event_id:)
  end
end
