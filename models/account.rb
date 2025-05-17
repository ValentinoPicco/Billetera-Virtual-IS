class Account < ActiveRecord::Base
    # Assosiations

    belongs_to :user

    has_one :card

    has_many :account_contacts
    has_many :contact_accounts, through: :account_contacts, source: :contact_account

    has_many :source_transactions, class_name: 'Transaction', foreign_key: :source_account_id
    has_many :target_transactions, class_name: 'Transaction', foreign_key: :target_account_id
end

