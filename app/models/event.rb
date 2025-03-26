class Event < ApplicationRecord
    has_many :event_registrations, dependent: :destroy # this deletes all event registrations upon event.destroy
    has_many :attendees, through: :event_registrations, source: :attendee
    has_many_attached :resources

    belongs_to :organizer, class_name: "User", foreign_key: "organizer_id"
    belongs_to :venue, optional: true

    validate  :end_time_after_start_time
    validates :name, :organizer_id, :start_time, :end_time, presence: true
    validates :event_type, presence: true, inclusion: { in: %w[conference workshop seminar competition other] }

  def end_time_after_start_time
    if start_time.present? && end_time.present? && end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
