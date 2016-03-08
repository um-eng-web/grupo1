require_relative '../Business/utilizador'
class Administrador < Utilizador
  attr_accessor :pw_secreta

  def initialize (email, pw ,pw_s = "123")
    super("Admin", email, pw)
    @pw_secreta = pw_s
  end
end