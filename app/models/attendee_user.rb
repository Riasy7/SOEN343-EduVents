class AttendeeUser < User
  has_many :event_registrations, foreign_key: :attendee_id

  validates :attendee_type, presence: true, inclusion: { in: %(speaker listener) }
end
