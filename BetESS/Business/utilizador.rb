class Utilizador
  @@ADMIN = 1
  @@APOSTADOR = 2
  @@BOOKIE = 3

  attr_accessor :nome
  attr_accessor :email
  attr_reader :password

  def initialize (name = '', email = '', password = '')
    @nome = name
    @email = email.downcase
    @password = password
  end

  def ==(o)
    o.class == self.class && o.nome == self.nome && o.email == self.email && o.password == self.password
  end


end
