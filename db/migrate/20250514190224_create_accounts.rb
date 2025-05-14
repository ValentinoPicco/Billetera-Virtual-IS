class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: false, primary_key: :cvu do |t|
      t.integer :cvu, null: false
      t.string :alias
      t.decimal :saldo_total, precision: 10, scale: 2 
      t.date :fecha_creacion
      t.string :password, null: false

      t.timestamps
    end
  end
end
