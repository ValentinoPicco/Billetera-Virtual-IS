class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :nom_service
      t.integer :monto_mensual
      t.date :fecha_pago

      t.timestamps
    end
  end
end
