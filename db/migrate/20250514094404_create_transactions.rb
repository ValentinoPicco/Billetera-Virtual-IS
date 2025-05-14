class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: false, primary_key: num_operation do |t|
      t.integer :num_operation
      t.date :date
      t.integer :type
      t.decimal :value, presicion: 10,  scale: 2
      t.string :reason
      t.timestamps
    end
  end
end