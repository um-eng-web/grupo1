class Evento
  @@FECHAR_EVENTO = 1
  @@CONCLUIR_EVENTO = 2
  @@CHANGE_ODDS = 3
  @@EVENTO_NAO_CONCLUIDO = -1

  attr_accessor :id, :team1, :team2, :odds_atuais, :historico_odds, :resultado, :is_open, :desporto, :closing_time, :bookie # Observer

  def initialize (id, team1, team2, odd_team1, odd_empate, odd_team2, is_open, desporto, closing_time, bookie)
    @id = id
    @team1, @team2 = team1, team2
    @odd_team1, @odd_empate, @odd_team2 = odd_team1, odd_empate, odd_team2
    @odds_atuais = Odd.new(odd_team1, odd_empate, odd_team2, Time.now)
    @historico_odds = [@odds_atuais]
    @is_open = is_open
    @desporto = desporto
    @closing_time = closing_time
    @bookie = bookie
  end
end