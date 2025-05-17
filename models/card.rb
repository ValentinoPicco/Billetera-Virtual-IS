class Card < ActiveRecord::Base
	# Assosiation
	
	belongs_to :account_holder, class_name: 'Account', foreign_key: :account_holder_id
end

