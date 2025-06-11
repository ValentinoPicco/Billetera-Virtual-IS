# models/transaction.rb
require 'active_record'
require 'securerandom' # Necesario para SecureRandom.uuid

class Transaction < ActiveRecord::Base
  # Asociaciones
  belongs_to :source_account, class_name: 'Account', foreign_key: 'source_account_id'
  belongs_to :target_account, class_name: 'Account', foreign_key: 'target_account_id'

  # enum para tipos de transacción
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
  # validates :no_operation, presence: true, uniqueness: true
  validates :no_operation, presence: true, uniqueness: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true
  validates :date, presence: true

  # Método de clase para realizar la transferencia de dinero con el cvu
  # Este método encapsula toda la lógica de negocio y la transacción de DB
  def self.transfer_money__by_cvu(sender_cvu, receiver_cvu, amount)

    # Validar que el monto sea positivo antes de iniciar la transacción
    unless amount > 0
      raise ActiveRecord::RecordInvalid.new(Transaction.new), "El monto debe ser mayor que cero."
    end

    # Iniciar una transacción para asegurar la atomicidad de las operaciones
    ActiveRecord::Base.transaction do

      sender_account = Account.find_by!(cvu: sender_cvu)
      receiver_account = Account.find_by!(cvu: receiver_cvu)

      unless sender_account.total_balance >= amount
        raise ActiveRecord::RecordInvalid.new(sender_account), "Saldo insuficiente en la cuenta del remitente."
      end

      sender_account.update!(total_balance: sender_account.total_balance - amount)
      receiver_account.update!(total_balance: receiver_account.total_balance + amount)

      no_operation = SecureRandom.uuid # Genera un Numero de operacion

      # Crear la transacción solo después de que los saldos se hayan actualizado con éxito
      transaction = Transaction.create!(
        no_operation: no_operation,
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

  # Método de clase para realizar la transferencia de dinero usando alias
  # La logica es igual a la del metodo anterior

  def self.transfer_money_by_alias(sender_alias, receiver_alias, amount)
    # Validar que el monto sea positivo antes de iniciar la transacción
    unless amount > 0
      raise ActiveRecord::RecordInvalid.new(Transaction.new), "El monto debe ser mayor que cero."
    end

    # Iniciar una transacción para asegurar la atomicidad de las operaciones
    ActiveRecord::Base.transaction do
      sender_account = Account.find_by!(alias: sender_alias)
      receiver_account = Account.find_by!(alias: receiver_alias)

      unless sender_account.total_balance >= amount
        raise ActiveRecord::RecordInvalid.new(sender_account), "Saldo insuficiente en la cuenta del remitente."
      end

      sender_account.update!(total_balance: sender_account.total_balance - amount)
      receiver_account.update!(total_balance: receiver_account.total_balance + amount)

      no_operation = SecureRandom.uuid

      transaction = Transaction.create!(
        no_operation: no_operation,
        value: amount,
        transaction_type: :transferencia_enviada,
        date: Date.current,
        source_account: sender_account,
        target_account: receiver_account
      )

      transaction
    end
  rescue ActiveRecord::RecordNotFound => e
    raise StandardError, "Error de cuenta: #{e.message}"
  rescue ActiveRecord::RecordInvalid => e
    raise StandardError, "Error de validación: #{e.message}"
  rescue => e
    raise StandardError, "Error inesperado durante la transferencia: #{e.message}"
  end


  # Método de clase para pagar un servicio
  def self.pay_service(name_service, sender_cvu)
    ActiveRecord::Base.transaction do
      # Validaciones iniciales
      service = Service.find_by!(name_service: name_service)
      amount = service.monthly_amount
      
      unless amount > 0
        raise ActiveRecord::RecordInvalid.new(Transaction.new), "El monto debe ser mayor que cero."
      end

      sender_account = Account.find_by!(cvu: sender_cvu)
      
      unless sender_account.total_balance >= amount
        raise ActiveRecord::RecordInvalid.new(sender_account), "Saldo insuficiente."
      end

      # Actualizar saldo
      sender_account.update!(total_balance: sender_account.total_balance - amount)

      # Crear transacción
      transaction = Transaction.create!(
        no_operation: SecureRandom.uuid,
        value: amount,
        transaction_type: :pago_servicio,
        date: Date.current, 
        source_account: sender_account
      )
      
      # Registrar servicio pagado
      PayedService.create!(
        service_id: service.id,
        account_id: sender_account.id,
        pay_date: Date.current
      )

      transaction
    end
  rescue ActiveRecord::RecordNotFound => e
    raise StandardError, "Error: #{e.message}"
  rescue ActiveRecord::RecordInvalid => e
    raise StandardError, "Error de validación: #{e.message}"
  rescue => e
    raise StandardError, "Error inesperado: #{e.message}"
  end

end