require_relative '../Business/evento'

module Pesquisa

  def Pesquisa.get_eventos_abertos (eventos)
    return eventos.select { |_, evento| evento.is_open }
  end

  def Pesquisa.get_eventos_fechados (eventos)
    return eventos.select { |_, evento| !evento.is_open && evento.resultado == Evento::EVENTO_NAO_CONCLUIDO }
  end

end