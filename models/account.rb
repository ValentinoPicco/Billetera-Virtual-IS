class Account < ActiveRecord::Base
  def initialize(id_cuenta, cvu, saldo_total, fecha_creacion, contraseña, contactos)
    @id_cuenta = id_cuenta
    @cvu = cvu
    @fecha_creacion = fecha_creacion
    @contraseña = contraseña
    @contactos = contactos
  end
end

