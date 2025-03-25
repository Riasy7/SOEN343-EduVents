class Venue < ApplicationRecord
  has_many :events
  has_one :location

  validates :name, :max_capacity, :price_per_seat, presence: :true
  validates :price_per_seat, comparison: { greater_than_or_equal_to: 0.0 }
  validates :max_capacity, comparison: { greater_than: 0 }
end
