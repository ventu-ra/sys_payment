class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :card_number
      t.integer :amount
      t.string :currency
      t.string :status
      t.string :message

      t.timestamps
    end
  end
end
