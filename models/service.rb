class Service < ActiveRecord::Base
  belongs_to :account_holder, class_name: 'Account', foreign_key: :account_id
  has_many :account
end