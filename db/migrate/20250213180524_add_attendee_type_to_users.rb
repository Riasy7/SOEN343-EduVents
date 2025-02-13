class AddAttendeeTypeToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :attendee_type, :string
  end
end
