include PgSearch::Model

class Event < ApplicationRecord
  has_many :event_registrations, dependent: :destroy # this deletes all event registrations upon event.destroy
  has_many :attendees, through: :event_registrations, source: :attendee
  has_many :payments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many_attached :resources

  belongs_to :organizer, class_name: "User", foreign_key: "organizer_id"
  belongs_to :venue, optional: true

  pg_search_scope :search_by_attributes,
  against: :name,
  associated_against: {
    organizer: :first_name,
    venue: :name
  },
  using: {
    tsearch: { prefix: true }
  }

  scope :under_price, ->(price) {
    where("(price_cents IS NULL OR price_cents = 0 OR price_cents <= ?)", price.to_i * 100) if price.present?
  }
  scope :sort_by_price, -> { order(Arel.sql("COALESCE(price_cents, 0) ASC")) }
  scope :sort_by_date, -> { order(start_time: :desc) }

  validate :end_time_after_start_time
  validates :name, :organizer_id, :start_time, :end_time, presence: true
  validates :event_type, presence: true, inclusion: { in: %w[conference workshop seminar competition other] }
  validate :start_and_end_within_venue_schedule

  def full_venue_address
    return "" unless venue&.location

    [
      venue.location.address1,
      venue.location.address2,
      venue.location.city,
      venue.location.state,
      venue.location.postal_code,
      venue.location.country
    ].compact.join(" ")
  end



  def end_time_after_start_time
    if start_time.present? && end_time.present? && end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def average_rating
    ratings.average(:rating).to_f.round(2)
  end
  private

  def start_and_end_within_venue_schedule
    return unless venue && venue.schedule.present?

    valid_slot = venue.schedule.any? do |slot|
      slot_start = DateTime.parse(slot["start_time"])
      slot_end = DateTime.parse(slot["end_time"])

      (start_time >= slot_start && end_time <= slot_end)
    end

    unless valid_slot
      errors.add(:start_time, "Event times must fall within the venue's available schedule.")
    end
  rescue ArgumentError => e
    errors.add(:start_time, "Invalid schedule times for the venue: #{e.message}")
  end
end
