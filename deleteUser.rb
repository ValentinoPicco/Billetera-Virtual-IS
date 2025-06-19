require_relative 'server'
user = User.find_by(dni: 1234)
if user
  user.account&.source_transactions&.destroy_all
  user.account&.target_transactions&.destroy_all
  user.account&.destroy
  user.destroy
  puts "Usuario eliminado correctamente"
end
