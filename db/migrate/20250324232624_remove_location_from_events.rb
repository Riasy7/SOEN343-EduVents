class RemoveLocationFromEvents < ActiveRecord::Migration[8.0]
  def change
    remove_column :events, :location, :string
  end
end
