class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: false do |t|
      t.integer :num_operation, null: false
      t.date :date
      t.integer :transaction_type, default: 0, null: false
      t.decimal :value, precision: 10, scale: 2
      t.string :reason
      t.timestamps
    end

    # Declaramos num_operation como clave primaria
    execute "ALTER TABLE transactions ADD PRIMARY KEY (num_operation);"
  end
end
