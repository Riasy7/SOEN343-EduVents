class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :website
      t.string :phone

      t.timestamps
    end
  end
end
