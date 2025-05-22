# models/transaction.rb
require 'active_record'
require 'securerandom' # Necesario para SecureRandom.uuid

class Transaction < ActiveRecord::Base
  # Asociaciones
  # Asegúrate de que las migraciones para Transaction incluyan source_account_id y target_account_id
  # Por ejemplo, en la migración:
  # t.references :source_account, foreign_key: { to_table: :accounts }, null: false
  # t.references :target_account, foreign_key: { to_table: :accounts }, null: false
  belongs_to :source_account, class_name: 'Account', foreign_key: 'source_account_id'
  belongs_to :target_account, class_name: 'Account', foreign_key: 'target_account_id'

  # Enum para tipos de transacción
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

  # Validaciones
  validates :num_operation, presence: true, uniqueness: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true
  validates :date, presence: true

  # Método de clase para realizar la transferencia de dinero
  # Este método encapsula toda la lógica de negocio y la transacción de DB
  def self.transfer_money(sender_cvu, receiver_cvu, amount)

    # Validar que el monto sea positivo antes de iniciar la transacción
    unless amount > 0
      raise ActiveRecord::RecordInvalid.new(Transaction.new), "El monto debe ser mayor que cero."
    end

    # Iniciar una transacción para asegurar la atomicidad de las operaciones
    ActiveRecord::Base.transaction do

      sender_account = Account.find_by!(cvu: sender_cvu)
      receiver_account = Account.find_by!(cvu: receiver_cvu)

      unless sender_account.saldo_total >= amount
        raise ActiveRecord::RecordInvalid.new(sender_account), "Saldo insuficiente en la cuenta del remitente."
      end

      sender_account.update!(saldo_total: sender_account.saldo_total - amount)
      receiver_account.update!(saldo_total: receiver_account.saldo_total + amount)

      num_operation = SecureRandom.uuid

      # Crear la transacción solo después de que los saldos se hayan actualizado con éxito
      transaction = Transaction.create!(
        num_operation: num_operation,
        value: amount,
        transaction_type: :transferencia_enviada, # Usamos el enum definido
        date: Date.current, 
        source_account: sender_account, 
        target_account: receiver_account
      )

      # Retornar la transacción creada si todo fue exitoso
      transaction
    end
  rescue ActiveRecord::RecordNotFound => e
    # Capturar si alguna cuenta no fue encontrada
    raise StandardError, "Error de cuenta: #{e.message}"
  rescue ActiveRecord::RecordInvalid => e
    # Capturar errores de validación (por ejemplo, saldo insuficiente, o validación de Account)
    raise StandardError, "Error de validación: #{e.message}"
  rescue => e
    # Capturar cualquier otro error inesperado
    raise StandardError, "Error inesperado durante la transferencia: #{e.message}"
  end

end
