class AccountContact < ActiveRecord::Base
	# Assosiations

	belongs_to :account
	belongs_to :contact_account, class_name: 'Account'
end