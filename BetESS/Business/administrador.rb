class Administrador < Utilizador
  attr_accessor :pw_secreta

  def initialize (user_name, pw ,pw_s = "123")
    super("Admin", user_name, pw)
    @pw_secreta = pw_s
  end

end