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
email = "teo@gmail.com"
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
    i = 0
    unique_alias = loop do
      generated_alias = name + surname + i.to_s
      i=i+1
      break generated_alias unless Account.exists?(alias: generated_alias)
    end
    account = Account.create!(
      user: user,
      cvu: generate_unique_cvu,
      alias: unique_alias,
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

name = "Valentino"
surname = "Picco"
dni = "45935762"
tel = "3584415816"
email = "piccovaletino2004@gmail.com"
address = "General Paz 768"
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
    i = 0
    unique_alias = loop do
      generated_alias = name + surname + i.to_s
      i=i+1
      break generated_alias unless Account.exists?(alias: generated_alias)
    end
    account = Account.create!(
      user: user,
      cvu: generate_unique_cvu,
      alias: unique_alias,
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

name = "Francisco"
surname = "Miani"
dni = "101010"
tel = "111110010"
email = "mianifrancisco04@gmail.com"
address = "Mansila 342"
password = 'mianimiani'

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
    i = 0
    unique_alias = loop do
      generated_alias = name + surname + i.to_s
      i=i+1
      break generated_alias unless Account.exists?(alias: generated_alias)
    end
    account = Account.create!(
      user: user,
      cvu: generate_unique_cvu,
      alias: unique_alias,
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

name = "Diego"
surname = "Armandovic"
dni = "31293129"
tel = "94949494"
email = "deigoete@gmail.com"
address = "Marado 123312"
password = 'marado'

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
    i = 0
    unique_alias = loop do
      generated_alias = name + surname + i.to_s
      i=i+1
      break generated_alias unless Account.exists?(alias: generated_alias)
    end
    account = Account.create!(
      user: user,
      cvu: generate_unique_cvu,
      alias: unique_alias,
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

