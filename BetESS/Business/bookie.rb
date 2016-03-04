class Bookie < Utilizador
  attr_accessor :eventos_bookie
  attr_accessor :notificacoes

  def initialize (nome = '', email = '', password = '', eventos_bookie = Hash.new, notificacoes = [])
    super(nome, email, password)
    @eventos_bookie = eventos_bookie
    @notificacoes = notificacoes
  end

  # TODO - Observer part
end