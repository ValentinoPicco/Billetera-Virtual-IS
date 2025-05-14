class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :nom_service
      t.decimal :monto_mensual, precision: 10, scale: 2
      t.date :fecha_pago

      t.timestamps
    end
  end
end
