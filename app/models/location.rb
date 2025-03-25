class Location < ApplicationRecord
  belongs_to :organization
  belongs_to :venue

  validates :name, :address1, :city, :state, :country, presence: true
  validates :postal_code, format: { with: /\A[A-Za-z0-9\s\-]+\z/, message: "must be a valid postal code" }, allow_blank: true
  validates :name, uniqueness: { scope: :organization_id, message: "must be unique within the same organization" }

  def get_full_address
    "#{address1} #{address2}, #{city}, #{state}, #{country}"
  end
end
