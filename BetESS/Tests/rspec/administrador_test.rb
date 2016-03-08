require 'minitest/autorun'
require_relative '../../Business/administrador'
require_relative '../../Business/utilizador'

class BetESSTest < Minitest::Test

  def setup
    @administrador = Administrador.new('ester@email.pt', '123clara123', 'asdfgk124jagsdy')
  end

  def test_init_administrador
    assert_equal('ester@email.pt', @administrador.email)
    assert_equal('123clara123', @administrador.password)
    assert_equal('asdfgk124jagsdy', @administrador.pw_secreta)
  end

end