class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, :event_id, :amount, :status, presence: true
  validates :status, inclusion: { in: %w[paid failed pending], message: "%{value} is not a valid status" }

  scope :successful, -> { where(status: 'paid') }
  scope :failed, -> { where(status: 'failed') }

  after_save :register_attendee_if_paid

  private

  def register_attendee_if_paid
    return unless status == 'paid'

    if user.is_a?(AttendeeUser) && !EventRegistration.exists?(event: event, attendee: user)
      EventRegistration.create!(event: event, attendee: user, role: user.attendee_type)
    end
  end
end