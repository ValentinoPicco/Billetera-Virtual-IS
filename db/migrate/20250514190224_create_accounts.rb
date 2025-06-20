class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.integer :cvu, null: false
      t.string :alias, null: false
      t.integer :total_balance
      t.date :creation_date
      t.timestamps
    end
  end
end
