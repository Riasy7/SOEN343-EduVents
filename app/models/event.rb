class Event < ApplicationRecord
    has_many :event_registrations
    has_many :attendees, through: :event_registrations, source: :attendee
    has_many_attached :resources

    belongs_to :organizer, class_name: "User", foreign_key: "organizer_id"
    belongs_to :venue, optional: true

    validates :name, presence: true
    validates :event_type, presence: true, inclusion: { in: %w[conference workshop seminar competition other] }
    validates :organizer_id, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validate  :end_time_after_start_time

  def end_time_after_start_time
    if start_time.present? && end_time.present? && end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
