require 'minitest/autorun'
require_relative '../../Business/utilizador'

class UtilizadorTest < Minitest::Test

  def setup
    @utilizador = Utilizador.new('Pablo', 'pand@email.pt', 'pablo123')
  end

  def test_init_utilizador
    assert_equal('Pablo', @utilizador.nome)
    assert_equal('pand@email.pt', @utilizador.email)
    assert_equal('pablo123', @utilizador.password)
  end



end