class AttendeeUser < User
  validates :attendee_type, presence: true, inclusion: { in: %(speaker listener) }
end
