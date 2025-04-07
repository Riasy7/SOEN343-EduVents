class AddScheduleToVenues < ActiveRecord::Migration[8.0]
  def change
    add_column :venues, :schedule, :json
  end
end
