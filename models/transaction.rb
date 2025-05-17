class Transaction < ActiveRecord::Base

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
  belongs_to :source_account, class_name: 'Account', foreign_key: :source_account_id
  belongs_to :destination_account, class_name: 'Account', foreign_key: :destination_account_id


  #before create
  #after create

end