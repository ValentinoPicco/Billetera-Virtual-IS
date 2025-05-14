class Transaction < ActiveRecord::Base
  self.primary_key = 'num_operation'

  enum type: {
    TRASFERENCIA_RECIBIDA: 0,
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