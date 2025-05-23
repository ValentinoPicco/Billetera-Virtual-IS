class User < ActiveRecord::Base
    has_one :account
    
    validates :dni, :name, :surname, :email, :tel, :address, presence: true
end
