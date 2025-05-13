class User < ActiveRecord::Base

  attr_reader :dni, :name, :surname, :email, :tel, :address #attr_accessor ??

  def initialize(dni, name, surname, email, tel, address)
    @dni = dni
    @name = name
    @surname = surname
    @email = email
    @tel = tel
    @address = address
  end

end
