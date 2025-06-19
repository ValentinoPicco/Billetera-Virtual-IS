class RenameAndChangeNoCardInCards < ActiveRecord::Migration[8.0]
  # corrije tabla cards
  def change
    rename_column :cards, :No_card, :no_card
    change_column :cards, :no_card, :string
  end
end