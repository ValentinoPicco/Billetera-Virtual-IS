class CreateCard < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.integer :nro_tarjeta
      t.references :account_holder, foreign_key: { to_table: :accounts }
      t.integer :cvv
      t.string :type
      t.string :fecha_creacion
      t.string :fecha_vto
      t.string :nombre_titular
      t.timestamps
    end
  end
end
