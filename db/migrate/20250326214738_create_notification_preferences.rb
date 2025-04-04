class CreateNotificationPreferences < ActiveRecord::Migration[8.0]
  def change
    create_table :notification_preferences do |t|
      t.references :user, foreign_key: true
      t.boolean :email_enabled
      t.boolean :sms_enabled

      t.timestamps
    end
  end
end
