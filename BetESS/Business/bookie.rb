class Bookie < Utilizador
  attr_accessor :notificacoes

  def initialize (nome = '', email = '', password = '', notificacoes = [])
    super(nome, email, password)
    @notificacoes = notificacoes
  end

  def ==(o)
    o.class == self.class && o.email == self.email && o.nome == self.nome
  end
  # TODO - Observer part
end