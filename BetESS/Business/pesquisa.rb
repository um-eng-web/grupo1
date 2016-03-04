require_relative '../Business/evento'

module Pesquisa

  def Pesquisa.get_eventos_abertos (eventos)
    return eventos.select { |_, evento| evento.is_open }
  end

end