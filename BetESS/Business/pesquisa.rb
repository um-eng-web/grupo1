require_relative '../Business/evento'

module Pesquisa

  def Pesquisa.get_eventos_abertos (eventos)
    return eventos.select { |_, evento| evento.is_open }
  end

  def Pesquisa.lista_aposta_abertas_pessoais (lista_apostas)
    lista_apostas.select { |_, aposta| aposta.is_open}
  end

end