require_relative 'server'
account = Account.find_by(user_id:8)
account&.source_transactions&.destroy_all
account&.target_transactions&.destroy_all
account&.destroy
puts "Usuario eliminado correctamente"
user = User.find_by(dni: 46)
if user
  user.account&.source_transactions&.destroy_all
  user.account&.target_transactions&.destroy_all
  user.account&.destroy
  user.destroy
  puts "Usuario eliminado correctamente"
end
