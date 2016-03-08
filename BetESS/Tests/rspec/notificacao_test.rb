require 'minitest/autorun'
require_relative '../../Business/notificacao'

class NotificacaoTest < Minitest::Test

  def setup
    @notificacao = Notificacao.new(1, 10, 'abc')
  end

  def test_init_notificacao
    assert_equal(1, @notificacao.id_evento)
    assert_equal(10, @notificacao.quantia_ganha)
    assert_equal('abc', @notificacao.descricao)
  end


end