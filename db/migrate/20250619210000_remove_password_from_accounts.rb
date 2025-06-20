class RemovePasswordFromAccounts < ActiveRecord::Migration[8.0]
  def change
    remove_column :accounts, :password, :string
  end
end
