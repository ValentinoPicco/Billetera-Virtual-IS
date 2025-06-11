class CreatePayedServices < ActiveRecord::Migration[8.0]
  def change
    create_table :payed_services do |t|
      t.references :service, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.date :pay_date
      t.timestamps
    end
  end
end