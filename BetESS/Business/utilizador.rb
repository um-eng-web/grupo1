class Utilizador
  @@ADMIN = 1
  @@APOSTADOR = 2
  @@BOOKIE = 3

  attr_accessor :nome
  attr_accessor :email
  attr_reader :password

  def initialize (name = '', email = '', password = '')
    @name = name
    @email = email.downcase
    @password = password
  end
end
