class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.decimal :amount
      t.string :currency
      t.string :status
      t.string :stripe_payment_intent_id
      t.string :stripe_charge_id

      t.timestamps
    end
  end
end
