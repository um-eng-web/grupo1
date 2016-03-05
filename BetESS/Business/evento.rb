require_relative '../Business/odd'
require_relative '../Exceptions/bookie_nao_autorizado_error'
require 'observer'

class Evento
  include Observable
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
    @team1, @team2 = team1.upcase, team2.upcase
    @odd_team1, @odd_empate, @odd_team2 = odd_team1, odd_empate, odd_team2
    @odds_atuais = Odd.new(odd_team1, odd_empate, odd_team2, Time.now)
    @historico_odds = [@odds_atuais]
    @is_open = is_open
    @desporto = desporto.upcase
    @closing_time = closing_time
    @bookie = bookie
    @resultado = EVENTO_NAO_CONCLUIDO
    self.add_observer(bookie)
  end

  def fechar_evento
    @is_open = false
    changed
    notify_observers(self, FECHAR_EVENTO)
  end

  def concluir_evento (resultado)
    @resultado = resultado
    changed
    notify_observers(self, CONCLUIR_EVENTO)
  end

  def mudar_odd (odd_team1, odd_team2, odd_empate, bookie)
    raise BookieNaoAutorizadoError, 'Não tem permissões para alterar esta odd!' unless bookie == self.bookie
    new_odd = Odd.new(odd_team1, odd_empate, odd_team2, Time.now)
    @historico_odds.push(new_odd)
    @odds_atuais = new_odd
    # Observer
    changed
    notify_observers(self, Evento::CHANGE_ODDS)
  end

  def to_s
    "\n\nModalidade: #{@desporto}\nEvento: #{@id}\nData de fecho: #{@closing_time.ctime}\n#{@team1} (#{@odds_atuais.odd_team1})\tEmpate (#{@odds_atuais.odd_empate})\t#{@team2} (#{@odds_atuais.odd_team2})"
  end

  def ==(o)
    o.class == self.class && o.id == self.id
  end
end