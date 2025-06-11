class PayedService < ActiveRecord::Base
  belongs_to :account
  belongs_to :service

  validates :pay_date, presence: true
end