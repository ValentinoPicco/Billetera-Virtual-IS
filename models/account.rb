class Account < ActiveRecord::Base
    # Assosiations

    belongs_to :user

    has_one :card, foreign_key: :account_holder_id, class_name: 'Card'

    has_many :pigs
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

  after_create :create_default_card

  def self.create_pig(name_pig, sender_cvu, amount)
    ActiveRecord::Base.transaction do
      raise ArgumentError, "El monto debe ser mayor que cero." unless amount > 0

      sender_account = Account.find_by!(cvu: sender_cvu)

      raise StandardError, "Saldo insuficiente." if sender_account.total_balance < amount

      sender_account.update!(total_balance: sender_account.total_balance - amount)

      Pig.create!(
        account: sender_account,
        name_pig: name_pig,
        total_balance: amount,
        creation_date: Date.current
      )
    end
  rescue ActiveRecord::RecordNotFound => e
    raise StandardError, "Cuenta no encontrada: #{e.message}"
  rescue ActiveRecord::RecordInvalid => e
    raise StandardError, "Error al crear el chanchito: #{e.message}"
  rescue => e
    raise StandardError, "Error inesperado: #{e.message}"
  end

  after_create :create_default_card

  private

  def create_default_card
    Card.create!(
      account_holder: self,
      no_card: SecureRandom.random_number(10**16).to_s.rjust(16, '0'),
      cvv: rand(100..999),
      creation_date: Date.current.to_s,
      exp_date: (Date.current >> 48).to_s, # 4 años después
      holder_name: "#{user.name} #{user.surname}"
    )
  end
end

