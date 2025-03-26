class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, :event_id, :amount, :status, presence: true

  scope :successful, -> { where(status: 'paid') }
  scope :failed, -> { where(status: 'failed') }

  def update_status!(new_status)
    update!(status: new_status)
  end
end