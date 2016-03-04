require_relative '../Business/evento'
class ApostaUtilizador < Evento

  attr_accessor :quantia, :escolha, :data_aposta

  def initialize (event, quantia, escolha, data)
    super(event.id, event.team1, event.team2, event.odds_atuais.odd_team1, event.odds_atuais.odd_empate, event.odds_atuais.odd_team2, event.is_open, event.desporto, event.closing_time, event.bookie)
    @quantia = quantia
    @escolha = escolha
    @data = data
  end
end