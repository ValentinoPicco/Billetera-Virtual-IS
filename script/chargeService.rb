require_relative 'server'
PayedService.delete_all
Service.delete_all


Service.create!(
  name_service: "Netflix Premium",
  monthly_amount: 1800000
)

Service.create!(
  name_service: "Disney+",
  monthly_amount: 1200000
)

Service.create!(
  name_service: "youtube music",
  monthly_amount: 300000
)

Service.create!(
  name_service: "primevideo",
  monthly_amount: 1200000
)

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
