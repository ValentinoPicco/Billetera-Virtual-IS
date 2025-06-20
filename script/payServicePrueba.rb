# payServicePrueba.rb
require_relative '../server'

user = User.find_or_create_by!(dni: "12345678") do |u|
  u.name = "John"
  u.surname = "Doe"
  u.tel = "1234567890"
  u.email = "john.doe@example.com"
  u.address = "123 Main St"
  u.password = "securepassword" 
end


service = Service.find_by(name_service: "Netflix Premium")
unless service
  service = Service.create!(
    name_service: "Netflix Premium",
    monthly_amount: 1500
  )
end



account = Account.find_by(cvu: 1234567890123456)
unless account
  account = Account.create!(
    user: user, 
    cvu: 1234567890123456,
    alias: "mybankaccount",
    total_balance: 5000000,
    creation_date: Date.current
  )
end


# Probar el método pay_service.
begin
  puts "\n=== Estado Inicial ==="
  puts "Saldo inicial: #{account.total_balance}"
  puts "Servicio: #{service.name_service} ($#{service.monthly_amount})"

  puts "\n=== Ejecutando pay_service ==="
  transaction = Transaction.pay_service("Netflix Premium", account.cvu)
  
  puts "\n=== Resultado ==="
  puts "Transacción exitosa! ID: #{transaction.id}"
  puts "Nuevo saldo: #{account.reload.total_balance}"
  puts "Servicio pagado registrado: #{PayedService.last.inspect}"
rescue => e
  puts "\n=== Error ==="
  puts "Error: #{e.message}"
  puts e.backtrace.first(5).join("\n")
end

