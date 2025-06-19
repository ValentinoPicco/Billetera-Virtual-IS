class CreatePig < ActiveRecord::Migration[8.0]
  def change
    create_table :pigs do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name_pig, null: false
      t.integer :total_balance
      t.date :creation_date
      t.timestamps
    end
  end
end