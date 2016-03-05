class Notificacao
  attr_accessor :id_evento, :quantia_ganha, :descricao

  def initialize (id_evento, quantia_ganha, descricao)
    @id_evento = id_evento
    @quantia_ganha = quantia_ganha
    @descricao = descricao
  end

  def to_s (evento)
    "\nNotificação sobre o evento:\n" + evento.to_s + "\nMensagem: #{@descricao}\n"
  end

  def to_s_apostador (evento)
    self.to_s(evento) + "\nQuantia ganha: #{@quantia_ganha}\n"
  end
end
