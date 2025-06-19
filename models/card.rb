class Card < ActiveRecord::Base
	# Assosiation
	
	belongs_to :account_holder, class_name: 'Account', foreign_key: :account_holder_id

  # Callback

  before_create :set_holder_name

  private

  def set_holder_name
    if holder_name.blank? && account_holder && account_holder.user
      self.holder_name = "#{account_holder.user.name} #{account_holder.user.surname}"
    end
  end
end

