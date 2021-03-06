require_relative '../Business/evento'
require_relative '../Business/utilizador'
require_relative '../Business/notificacao'
class Bookie < Utilizador

  attr_accessor :notificacoes

  def initialize (nome = '', email = '', password = '', notificacoes = [])
    super(nome, email, password)
    @notificacoes = notificacoes
  end

  def update (evento, tipo)
    case tipo
      when Evento::FECHAR_EVENTO
        n = Notificacao.new(evento.id, -1, 'O evento foi fechado')
        @notificacoes.push(n)
      when Evento::CONCLUIR_EVENTO
        n = Notificacao.new(evento.id, -1, 'O evento foi concluído')
        @notificacoes.push(n)
      else
        n = Notificacao.new(evento.id, -1, 'As odds deste evento foram alteradas')
        @notificacoes.push(n)
    end
  end

  def ==(o)
    o.class == self.class && o.email == self.email && o.nome == self.nome
  end

end