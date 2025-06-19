require 'active_record'
require_relative 'models/user'
require_relative 'models/account'
require_relative 'models/transaction'

require_relative 'server' # para tener acceso a App.generate_unique_cvu


def generate_unique_cvu
  loop do
    cvu = rand(10**16).to_s.rjust(16, '0')
    break cvu unless Account.exists?(cvu: cvu)
  end
end


name = "mateo"
surname = "Llorente"
dni = "46453070"
tel = "3585487"
email = "teo25@gmail.com"
address = "lavalle 1100"
password = '12345678'

existing_user = User.find_by(dni: dni)

if existing_user
  puts "Usuario con DNI #{dni} ya existe. Omitido."
else
  user = User.create!(
    name: name,
    surname: surname,
    dni: dni,
    tel: tel,
    email: email,
    address: address,
    password: password
  )
  if user.save
    account = Account.create!(
      user: user,
      cvu: generate_unique_cvu,
      alias: "#{name.downcase}#{surname.downcase}",
      total_balance: 0,
      creation_date: Time.now,
      password: password
    )

    # Les damos dinero de prueba
    Transaction.deposit_money(user, 10000000) # $100000
    puts "Usuario creado: #{name} #{surname} (DNI #{dni}, alias #{account.alias})"
  else
    puts "Error creando usuario 1"
  end
  puts "Usuario #{name} #{surname} creado con éxito."
end

