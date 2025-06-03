class Account < ActiveRecord::Base
    # Assosiations

    belongs_to :user

    has_one :card
    has_many :other_cards, foreign_key: :account_holder_id

    has_many :account_contacts
    has_many :contact_accounts, through: :account_contacts, source: :contact_account

    has_many :source_transactions, class_name: 'Transaction', foreign_key: :source_account_id
    has_many :target_transactions, class_name: 'Transaction', foreign_key: :target_account_id

  validates :user, presence: true   # debe estar asociado a un usuario
  validates :cvu, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :alias, presence: true, uniqueness: true
  validates :total_balance, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :creation_date, presence: true
  validates :password, presence: true, length: { minimum: 6 }

end

