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