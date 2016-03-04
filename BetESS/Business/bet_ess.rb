class BetESS < Evento

  attr_accessor :saldo_inicial, :next_id_aposta, :search, :utilizadores, :eventos

  def initialize (utilizadores, eventos)
      @utilizadores = utilizadores
      @eventos = eventos
      @search = Pesquisa.new
  end

end