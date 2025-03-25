class CreateVenues < ActiveRecord::Migration[8.0]
  def change
    create_table :venues do |t|
      t.string  :name, null: false
      t.integer :max_capacity, null: false
      t.decimal :price_per_seat, precision: 10, scale: 2, null: false

      # each venue will have a location
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
