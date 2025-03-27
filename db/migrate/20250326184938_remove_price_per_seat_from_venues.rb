class RemovePricePerSeatFromVenues < ActiveRecord::Migration[8.0]
  def change
    remove_column :venues, :price_per_seat, :float
  end
end
