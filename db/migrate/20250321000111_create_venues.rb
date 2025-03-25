class CreateVenues < ActiveRecord::Migration[8.0]
  def change
    create_table :venues do |t|
      t.string  :name, null: false
      t.integer :max_capacity, null: false
      t.decimal :price_per_seat, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
