class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: false, primary_key: num_operation do |t|
      t.integer :num_operation, null: false
      t.date :date
      t.integer :type, default: 0, null: false # tTransaction
      t.decimal :value, presicion: 10,  scale: 2
      t.string :reason
      t.timestamps
    end

    # Declaramos id_service como clave primaria
    execute "ALTER TABLE transactions ADD PRIMARY KEY (num_operation);"
  end
end