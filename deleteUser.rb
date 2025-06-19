require_relative 'server'

dni = 46453070
user = User.find_by(dni: dni)

if user
  account = user.account

  if account
    account.card&.destroy

    # Destruir transacciones como fuente
    account.source_transactions.find_each(&:destroy)

    # Destruir transacciones como destino
    account.target_transactions.find_each(&:destroy)

    # Destruir chanchitos (pigs)
    account.pigs.find_each(&:destroy)

    account.destroy
  end

  # Destruir el usuario
  user.destroy
  puts "✅ Usuario eliminado correctamente"
else
  puts "❌ No se encontró usuario con DNI #{dni}"
end
