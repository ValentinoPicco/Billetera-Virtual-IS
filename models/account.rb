class Account < ActiveRecord::Base
    belongs_to :user

    has_many :contact_account, class_name: 'Account', foreign_key: :contact_account_id
    has_many :transaction
    has_many :source_transacction, class name: 'Transaction', foreing key: source_account_id
    has_many :destination_transacction, class name: 'Transaction', foreing key: destination_account_id
end

