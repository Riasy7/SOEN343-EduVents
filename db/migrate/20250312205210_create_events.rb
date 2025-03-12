class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name, null:false
      t.text :description
      t.string :event_type, null:false
      t.string :location, null:false
      t.integer :organizer_id, null:false
      t.datetime :published_at

      t.timestamps
    end

    add_foreign_key :events, :users, column: :organizer_id
  end
end
