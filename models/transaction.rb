class Transaction < ActiveRecord::Base
  # Associations
  belongs_to :source_account, class_name: 'Account', foreign_key: :source_account_id
  belongs_to :target_account, class_name: 'Account', foreign_key: :target_account_id

  # Enum
  
 enum :transaction_type, {
  transferencia_recibida: 0,
  transferencia_enviada: 1,
  salario: 2,
  devolucion: 3,
  deposito: 4,
  adelanto_de_sueldo: 5,
  pago_servicio: 6,
  compra: 7,
  retiro: 8
  }

  validates :num_operation, presence: true, uniqueness: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true
  validates :date, presence: true

  # llamar Callback que actualiza los saldos
  after_create :actualizar_saldos


  private
  def actualizar_saldos

    if source_account
      source_account.update(saldo_total: source_account.saldo_total - value)
    end

    if target_account
      target_account.update(saldo_total: target_account.saldo_total + value)
    end
  end


end