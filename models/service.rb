class Service < ActiveRecord::Base
  has_many :payed_services

  validates :name_service, presence: true, uniqueness: true
  validates :monthly_amount, presence: true, numericality: { greater_than: 0 }
end