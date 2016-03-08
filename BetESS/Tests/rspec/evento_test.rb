require 'minitest/autorun'
require_relative '../../Business/evento'
require_relative '../../Business/bookie'
require_relative '../../Business/odd'

class EventoTest < Minitest::Test

  def setup
    @data = Time.now
    @bookie = Bookie.new('Carlos', 'carlos@email.pt', '123carlos123')
    @evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', @data, @bookie)
  end

  def test_init_evento
    assert_equal(1, @evento.id)
    assert_equal('FC Porto'.upcase, @evento.team1)
    assert_equal('SL Benfica'.upcase, @evento.team2)
    assert_equal(1.01, @evento.odds_atuais.odd_team1)
    assert_equal(1.21,  @evento.odds_atuais.odd_empate)
    assert_equal(200.0,  @evento.odds_atuais.odd_team2)
    assert_equal(true,  @evento.is_open)
    assert_equal('Futebol'.upcase,@evento.desporto)
    assert_equal(@data, @evento.closing_time)
    assert_equal(@bookie, @evento.bookie)
  end


  def test_fechar_evento
    @evento.fechar_evento
    assert_equal(false,@evento.is_open)
  end

  def test_concluir_evento
    @evento.concluir_evento(1)
    assert_equal(1, @evento.resultado)
  end

  def test_mudar_odd_error
    bookie_not_owner = Bookie.new('Manuel', 'manuel@email.pt', '123manuel123')
    assert_raises(BookieNaoAutorizadoError, 'Não tem permissões para alterar esta odd!') {@evento.mudar_odd(1, 2, 3, bookie_not_owner)}
  end

  def test_mudar_odd
    @evento.mudar_odd(1, 2, 3, @bookie)
    assert_equal(1, @evento.odds_atuais.odd_team1)
    assert_equal(3, @evento.odds_atuais.odd_empate)
    assert_equal(2, @evento.odds_atuais.odd_team2)
    assert_equal(2, @evento.historico_odds.size)
  end

end