class CreateCard < ActiveRecord::Migration[7.0]
  def change
    create_table :Card do |t|
      t.integer :nro_cuenta  
      t.integer :cvv
      t.string :fecha_creacion
      t.string :fecha_vto
      t.string :nombre_titular
      t.timestamps
    end
  end
end
