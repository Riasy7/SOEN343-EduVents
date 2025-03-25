class AddVenueToLocations < ActiveRecord::Migration[8.0]
  def change
    add_reference :locations, :venue, foreign_key: true
  end
end
