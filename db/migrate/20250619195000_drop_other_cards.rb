class DropOtherCards < ActiveRecord::Migration[8.0]
  def up
    drop_table :other_cards, if_exists: true
  end
end
