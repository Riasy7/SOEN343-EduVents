class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, :event_id, :amount, :status, presence: true
  validates :status, inclusion: { in: %w[paid failed pending], message: "%{value} is not a valid status" }

  scope :successful, -> { where(status: 'paid') }
  scope :failed, -> { where(status: 'failed') }
end