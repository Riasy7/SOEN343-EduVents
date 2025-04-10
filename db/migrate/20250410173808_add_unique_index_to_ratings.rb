class AddUniqueIndexToRatings < ActiveRecord::Migration[7.0] # adjust version if needed
  def change
    add_index :ratings, [:attendee_id, :event_id], unique: true
  end
end
