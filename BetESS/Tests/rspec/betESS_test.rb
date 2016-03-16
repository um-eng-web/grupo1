require 'minitest/autorun'
require_relative '../../Business/bet_ess'
require_relative '../../Business/utilizador'
require_relative '../../Business/bookie'
require_relative '../../Business/evento'
require_relative '../../Business/aposta_utilizador'
require_relative '../../Business/notificacao'

class AdministradorTest < Minitest::Test

  def setup
    @bet_ess = BetESS.new()
    @apostador = Apostador.new('John', 'john@email.pt', '12345john')
    @bet_ess.add_utilizador(@apostador)
    @bookie = Bookie.new('Carlos', 'carlos@email.pt', '123carlos123')
    @bet_ess.add_utilizador(@bookie)
    @bookie2 = Bookie.new('Broke', 'bb@email.pt', 'bb12345')
    @bet_ess.add_utilizador(@bookie2)
  end

  def test_add_utilizador
    utilizador = Apostador.new('Pablo', 'pand@email.pt', 'pablo123')
    @bet_ess.add_utilizador(utilizador)
    assert_equal(utilizador,@bet_ess.utilizadores['pand@email.pt'.to_sym])
  end

  def test_add_utilizador_error
    utilizador = Utilizador.new('Pablo', 'pand@email.pt', 'pablo123')
    @bet_ess.add_utilizador(utilizador)
    assert_raises(UtilizadorJaExisteError, 'Utilizador já existe') {@bet_ess.add_utilizador(utilizador)}
  end

  def test_login
    @bet_ess.login('john@email.pt', '12345john')
  end

  def test_login_user_inexistente_error
    assert_raises(UtilizadorInexistenteError, 'Utilizador não registado'){@bet_ess.login('inexistente@email.pt', '12345')}
  end

  def test_login_password_errada_error
    assert_raises(PasswordErradaError, 'Password incorreta'){@bet_ess.login('john@email.pt', 'password_errada')}
  end

  def test_add_evento
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', @data, @bookie)
    assert_equal(evento, @bet_ess.eventos[id])
  end

  def test_adicionar_quantia
    @bet_ess.adicionar_quant(10,@apostador)
    assert_equal(20,@bet_ess.utilizadores[@apostador.email.to_sym].saldo)
  end

  def test_retirar_quantia
    @bet_ess.retirar_quant(10, @apostador)
    assert_equal(0,@bet_ess.utilizadores[@apostador.email.to_sym].saldo)
  end

  def test_retirar_quantia_error
    assert_raises(FundosInsuficientesError, 'Lamentamos mas não tem saldo suficiente para realizar a operação'){@bet_ess.retirar_quant(20, @apostador)}
  end

  def test_get_user
    assert_equal(@apostador, @bet_ess.get_user('john@email.pt'))
  end
def test_fechar_evento
  data = Time.now
  id = @bet_ess.next_id_evento
  @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
  @bet_ess.fechar_evento(id)
  assert_equal(false, @bet_ess.eventos[id].is_open)
  assert_equal(Evento::EVENTO_NAO_CONCLUIDO,@bet_ess.eventos[id].resultado)
end

  def test_fechar_evento_error
    assert_raises(EventoInexistenteError, 'Evento inexistente ou já foi fechado anteriormente!') {@bet_ess.fechar_evento(50)}
  end

  def test_concluir_evento
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    @bet_ess.fechar_evento(id)
    @bet_ess.concluir_evento(id, 1)
    assert_equal(false, @bet_ess.eventos[id].is_open)
    assert_equal(1,@bet_ess.eventos[id].resultado)
  end

  def test_concluir_evento_error
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    assert_raises(EventoInexistenteError, 'Evento inexistente, ainda aberto ou já concluído') {@bet_ess.concluir_evento(id,1)}
  end

  def test_get_evento_aberto
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    ev = @bet_ess.get_evento_aberto(id)
    evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', @data, @bookie)
    assert_equal(evento, ev)
  end

  def test_get_evento_aberto_error
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    @bet_ess.fechar_evento(id)
    assert_raises(EventoInexistenteError, 'Não existe nenhum evento aberto com este identificador!'){@bet_ess.get_evento_aberto(id)}
  end

  def test_get_evento_fechado
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    @bet_ess.fechar_evento(id)
    ev = @bet_ess.get_evento(id)
    evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', @data, @bookie)
    assert_equal(evento, ev)
  end

  def test_get_evento_concluido
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    @bet_ess.fechar_evento(id)
    @bet_ess.concluir_evento(id, 1)
    ev = @bet_ess.get_evento(id)
    evento = Evento.new(1, 'FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, true, 'Futebol', @data, @bookie)
    assert_equal(evento, ev)
  end

  def test_mudar_odd
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    @bet_ess.mudar_odd(id, 1, 1, 1, @bookie)
    assert_equal(1, @bet_ess.get_evento(id).odds_atuais.odd_team1)
    assert_equal(1, @bet_ess.get_evento(id).odds_atuais.odd_team2)
    assert_equal(1, @bet_ess.get_evento(id).odds_atuais.odd_empate)
  end


  def test_registar_aposta
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    ev = @bet_ess.get_evento(id)
    @bet_ess.registar_aposta(ev, 0, 10, @apostador)
    utilizador = @bet_ess.utilizadores['john@email.pt'.to_sym]
    assert_equal(utilizador.lista_apostas[1].quantia, 10)
    assert_equal(utilizador.lista_apostas[1].escolha, 0)
  end

  def test_registar_interesse
    data = Time.now
    id = @bet_ess.next_id_evento
    @bet_ess.add_evento('FC Porto', 'SL Benfica', 1.01, 1.21, 200.0, 'Futebol', data, @bookie)
    @bet_ess.registar_interesse_em_evento(id, @bookie2)
    @bet_ess.mudar_odd(id, 1, 1, 1, @bookie)
    assert_equal(1, @bet_ess.utilizadores[@bookie2.email.to_sym].notificacoes.size)
    assert_equal(id, @bet_ess.utilizadores[@bookie2.email.to_sym].notificacoes[0].id_evento)
  end


end