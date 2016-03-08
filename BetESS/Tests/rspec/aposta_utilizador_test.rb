require 'minitest/autorun'
require_relative '../../Business/aposta_utilizador'
require_relative '../../Business/bookie'
require_relative '../../Business/evento'

class ApostaUtilizadorTest < Minitest::Test

  def setup
    @bookie = Bookie.new('Carlos', 'carlos@email.pt', '123carlos123')
    @evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', Time.new(2016, 03, 1, 2, 2, 2), @bookie)
    @aposta_utilizador = ApostaUtilizador.new(@evento, 10, 1,Time.new(2016, 03, 1, 2, 2, 2, "+02:00"))
  end

  def test_init_aposta_utilizador
    assert_equal(Time.new(2016, 03, 1, 2, 2, 2, "+02:00"), @aposta_utilizador.data_aposta)
    assert_equal(1, @aposta_utilizador.escolha)
    assert_equal(10, @aposta_utilizador.quantia)
  end


end