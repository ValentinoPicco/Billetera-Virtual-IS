class Card < ActiveRecord::Base
	# Assosiation
	
	belongs_to :account_holder, class_name: 'Account', foreign_key: :account_holder_id

  # Callback

  before_create :set_nombre_titular

  private

  def set_nombre_titular
    self.nombre_titular = account_holder.user.name if nombre_titular.blank?
  end
end

