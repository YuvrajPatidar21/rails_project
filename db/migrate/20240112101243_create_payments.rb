class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :card_holder_name
      t.bigint :card_number
      t.integer :cvv
      t.string :bank_name
      t.decimal :amount
      t.date :payment_date, default: Date.today
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
