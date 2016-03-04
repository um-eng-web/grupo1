require_relative '../Business/evento'

module Pesquisa

  def get_eventos_abertos (eventos)
     eventos.select { |_, evento| evento.is_open }
  end

  def get_apostas_abertas_apostador (lista_apostas)
    lista_apostas.select { |_, aposta| aposta.is_open}
  end

  def get_eventos_fechados (eventos)
     eventos.select { |_, evento| !evento.is_open && evento.resultado == Evento::EVENTO_NAO_CONCLUIDO }
  end

  def get_eventos_do_bookie(eventos, bookie)
     eventos.select { |_, evento| evento.bookie == bookie }
  end

  def get_eventos_do_bookie_fechados(eventos, bookie)
     eventos.select { |_, evento| evento.bookie == bookie && !evento.is_open }
  end

  def get_eventos_do_bookie_abertos(eventos, bookie)
     eventos.select { |_, evento| evento.bookie == bookie && evento.is_open }
  end

end