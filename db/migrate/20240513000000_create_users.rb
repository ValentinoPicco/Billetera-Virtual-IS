class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :dni
      t.string :name
      t.string :surname
      t.string :email
      t.string :tel
      t.string :address

      t.timestamps
    end
  end
end
