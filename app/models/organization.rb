class Organization < ApplicationRecord
    validates :name, presence: true
    validates :website, format: { with: /\Ahttps?:\/\/[\S]+\z/, message: "must be a valid URL" }, allow_blank: true
    validates :phone, format: { with: /\A\+?[0-9]{10,15}\z/, message: "must be a valid phone number" }, allow_blank: true
    validates :locations, presence: { message: "must have at least one location" }
    
    has_many :users
    has_many :locations, dependent: :destroy

    accepts_nested_attributes_for :locations
end
