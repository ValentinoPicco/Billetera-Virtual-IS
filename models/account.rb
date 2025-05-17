class Account < ActiveRecord::Base
    belongs_to :user

    has_many :contact_account, class_name: 'Account', foreign_key: :contact_account_id
    # has_many :transaction
    #has_many :source_transacction, class name: 'transaction', foreing key transaction
end

