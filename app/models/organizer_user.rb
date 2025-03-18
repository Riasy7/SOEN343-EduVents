class OrganizerUser < User
    has_many :events, foreign_key: "organizer_id"
  end
  