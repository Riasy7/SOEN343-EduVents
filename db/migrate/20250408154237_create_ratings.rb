class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :event, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: { to_table: :users }
      t.integer :rating, null: false

      t.timestamps
    end

    add_index :ratings, [:event_id, :attendee_id], unique: true
  end
end