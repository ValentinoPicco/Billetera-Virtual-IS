class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :num_operation, null: false
      t.date :date
      t.integer :transaction_type, default: 0, null: false
      t.decimal :value, precision: 10, scale: 2
      t.string :reason
      t.timestamps
    end
  end
end