class CreateAccountContacts < ActiveRecord::Migration[8.0]
	def change
		create_table :account_contacts do |t|
			t.references :account, null: false, foreign_key: true
			t.references :contact_account, null: false, foreign_key: { to_table: :accounts }
			t.timestamps
		end
		
		# Evita tener contactos repetidos asegurando que no existan relaciones duplicadas
		# entre account_id y contact_account_id en la tabla account_contacts.
		add_index :account_contacts, [:account_id, :contact_account_id], unique: true
	end
end