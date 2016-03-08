require 'minitest/autorun'
require_relative '../../Business/bookie'
require_relative '../../Business/utilizador'
require_relative '../../Business/notificacao'

class BookieTest < Minitest::Test

  nome = '', email = '', password = '', notificacoes = []

  def setup
    @bookie = Bookie.new('Carlos', 'carlos@email.pt', '123carlos123')
  end

  def test_init_bookie
    assert_equal('Carlos', @bookie.nome)
    assert_equal('carlos@email.pt', @bookie.email)
    assert_equal('123carlos123', @bookie.password)
  end

  def test_notifications_number
    evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', Time.now, @bookie)
    @bookie.update(evento, Evento::CHANGE_ODDS)
    @bookie.update(evento, Evento::FECHAR_EVENTO)
    @bookie.update(evento, Evento::CONCLUIR_EVENTO)
    assert_equal(3,@bookie.notificacoes.size)
  end

  def test_update
    evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', Time.now, @bookie)
    @bookie.update(evento, Evento::CHANGE_ODDS)
    @bookie.update(evento, Evento::FECHAR_EVENTO)
    @bookie.update(evento, Evento::CONCLUIR_EVENTO)
    notificacoes = @bookie.notificacoes
    assert_equal(notificacoes[0].id_evento, 1)
    assert_equal(notificacoes[1].id_evento, 1)
    assert_equal(notificacoes[2].id_evento, 1)
    assert_equal(notificacoes[0].quantia_ganha, -1)
    assert_equal(notificacoes[1].quantia_ganha, -1)
    assert_equal(notificacoes[2].quantia_ganha, -1)
    assert_equal(notificacoes[0].descricao, 'As odds deste evento foram alteradas')
    assert_equal(notificacoes[1].descricao, 'O evento foi fechado')
    assert_equal(notificacoes[2].descricao, 'O evento foi concluído')

  end


end