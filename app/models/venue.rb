class Venue < ApplicationRecord
  belongs_to :organization

  has_many :events

  has_one :location
  accepts_nested_attributes_for :location, allow_destroy: true

  validates :name, :max_capacity, presence: :true
  validates :max_capacity, comparison: { greater_than: 0 }
end
