class User < ActiveRecord::Base

  def initialize(dni, name, surname, email, tel, address)
    @dni = dni
    @name = name
    @surname = surname
    @email = email
    @tel = tel
    @address = address
  end

end
