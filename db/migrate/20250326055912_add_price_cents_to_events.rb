class AddPriceCentsToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :price_cents, :integer
  end
end
