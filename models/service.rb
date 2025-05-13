class Service
    attr_reader :id_service, :nom_service, :monto_mensual, :fecha_pago

    def initialize(id_service, nom_service, monto_mensual, fecha_pago)
        @id_service = id_service
        @nom_service = nom_service
        @monto_mensual = monto_mensual
        @fecha_pago = fecha_pago
    end
end