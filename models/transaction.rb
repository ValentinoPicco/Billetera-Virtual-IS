class Transaction < ActiveRecord::Base
  # Associations
  belongs_to :source_account, class_name: 'Account', foreign_key: :source_account_id
  belongs_to :target_account, class_name: 'Account', foreign_key: :target_account_id

  # Enum
  enum transaction_type: {
    TRANSFERENCIA_RECIBIDA: 0,
    TRANSFERERENCIA_ENVIADA: 1,
    SALARIO: 2,
    DEVOLUCION: 3,
    DEPOSITO: 4,
    ADELANTO_DE_SUELDO: 5,
    PAGO_SERVICIO: 6,
    COMPRA: 7,
    RETIRO: 8
  }

end