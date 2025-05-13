class Card < ActiveRecord::Base
  def initialize(nro_cuenta, cvv, fecha_creacion, fecha_vto, nombre_titular)
    @nro_cuenta = nro_cuenta
    @cvv = cvv
    @fecha_creacion = fecha_creacion
    @fecha_vto = fecha_vto
    @nombre_titular = nombre_titular
  end
end

