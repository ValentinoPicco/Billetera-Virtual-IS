require 'bcrypt'
class User < ActiveRecord::Base
    has_secure_password
    
    has_one :account
    
    validates :dni, :name, :surname, :email, :tel, :address, presence: true 
    validates :email, uniqueness: true
end
