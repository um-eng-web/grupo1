require_relative '../Business/odd'

class Evento
  FECHAR_EVENTO = 1
  CONCLUIR_EVENTO = 2
  CHANGE_ODDS = 3
  EVENTO_NAO_CONCLUIDO = -1
  EQUIPA1 = 1
  EQUIPA2 = 2
  EMPATE = 0

  attr_accessor :id, :team1, :team2, :odds_atuais, :historico_odds, :resultado, :is_open, :desporto, :closing_time, :resultado, :bookie # Observer

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
    @resultado = EVENTO_NAO_CONCLUIDO
  end

  def fechar_evento
    @is_open = false
  end

  def concluir_evento (resultado)
    @resultado = resultado
    # TODO observer
  end

  def to_s
    "\n\nModalidade: #{@desporto}\nEvento: #{@id}\nData de fecho: #{@closing_time.ctime}\n#{@team1} (#{@odds_atuais.odd_team1})\tEmpate (#{@odds_atuais.odd_empate})\t#{@team2} (#{@odds_atuais.odd_team2})"
  end
end