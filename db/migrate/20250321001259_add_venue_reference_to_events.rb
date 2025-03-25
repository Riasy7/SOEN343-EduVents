class AddVenueReferenceToEvents < ActiveRecord::Migration[8.0]
  def change
    change_table :events do |t|
      t.references :venue, null: false, foreign_key: true
    end
  end
end
