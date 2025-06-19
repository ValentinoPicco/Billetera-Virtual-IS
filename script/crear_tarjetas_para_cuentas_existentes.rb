# script/crear_tarjetas_para_cuentas_existentes.rb

require 'bundler/setup'
require 'active_record'
require 'securerandom'
require 'yaml'

# Cargar configuración de la base de datos desde config/database.yml
db_config = YAML.load_file(File.expand_path('../config/database.yml', __dir__), aliases: true)
ActiveRecord::Base.establish_connection(db_config['development'])

# Requiere los modelos después de establecer la conexión
require_relative '../models/user'
require_relative '../models/account'
require_relative '../models/card'

Account.find_each do |account|
  unless account.card
    Card.create!(
      account_holder: account,
      no_card: SecureRandom.random_number(10**16).to_s.rjust(16, '0'),
      cvv: rand(100..999),
      creation_date: Date.current.to_s,
      exp_date: (Date.current >> 48).to_s,
      holder_name: account.user.name
    )
    puts "Tarjeta creada para la cuenta ##{account.id}"
  else
    puts "La cuenta ##{account.id} ya tiene tarjeta."
  end
end

puts "Proceso finalizado."
