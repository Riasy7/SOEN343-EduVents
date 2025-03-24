class Event < ApplicationRecord
    belongs_to :organizer, class_name: "User", foreign_key: "organizer_id"
    belongs_to :venue, optional: true

    validates :name, presence: true
    validates :event_type, presence: true, inclusion: { in: %w[conference workshop seminar competition other] }
    validates :organizer_id, presence: true
end
