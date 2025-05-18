class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.integer :num_operation, null: false
      t.references :source_account, foreign_key: { to_table: :accounts }, null: false
      t.references :target_account, foreign_key: { to_table: :accounts } 
      t.integer :value, null: false
      t.date :date, null: false
      t.integer :transaction_type, default: 0, null: false
      t.string :reason
      t.timestamps
    end
  end
end