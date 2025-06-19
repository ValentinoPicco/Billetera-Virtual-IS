class CreateCard < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :no_card
      t.references :account_holder, foreign_key: { to_table: :accounts }
      t.integer :cvv
      t.string :type
      t.string :creation_date
      t.string :exp_date
      t.string :holder_name
      t.timestamps
    end
  end
end
