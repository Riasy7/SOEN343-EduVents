class Venue < ApplicationRecord
  has_many :events
  has_one :location

  validates :name, :max_capacity, presence: :true
  validates :max_capacity, comparison: { greater_than: 0 }
end
