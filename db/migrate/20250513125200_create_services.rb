class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :name_service
      t.integer :monthly_amount
      t.date :pay_date
      t.references :account, null: false, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
