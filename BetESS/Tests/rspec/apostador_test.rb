require 'minitest/autorun'
require_relative '../../Business/apostador'
require_relative '../../Business/utilizador'

class ApostadorTest < Minitest::Test

  def setup
    @apostador = Apostador.new('Clara', 'clara@email.com', '123clara123')
  end

  def test_init_apostador
    assert_equal('Clara', @apostador.nome)
    assert_equal(10, @apostador.saldo)
    assert_equal('clara@email.com', @apostador.email)
    assert_equal('123clara123', @apostador.password)
  end

  def test_add_saldo
    @apostador.adiciona_saldo(10)
    assert_equal(20,@apostador.saldo)
  end

  def test_remove_saldo
    @apostador.remove_saldo(10)
    assert_equal(0, @apostador.saldo)
  end


end