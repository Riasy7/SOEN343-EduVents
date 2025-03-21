class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
