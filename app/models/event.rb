class Event < ApplicationRecord
    belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  
    validates :name, presence: true
    validates :event_type, presence: true, inclusion: { in: %w[conference workshop seminar competition other] }
    validates :location, presence: true
    validates :organizer_id, presence: true
  end
  