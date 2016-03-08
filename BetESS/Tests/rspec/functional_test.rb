require 'minitest/autorun'
require_relative '../../Business/bet_ess'
require_relative '../../Business/utilizador'
require_relative '../../Business/bookie'
require_relative '../../Business/evento'

class AdministradorTest < Minitest::Test

  def setup
    @bet_ess = BetESS.new()
    #@apostador = Apostador.new('John', 'john@email.pt', '12345john')
    #@bet_ess.add_utilizador(@apostador)
    #@bookie = Bookie.new('Carlos', 'carlos@email.pt', '123carlos123')
    #@bet_ess.add_utilizador(@bookie)
  end

  def test_add_utilizador
    utilizador = Apostador.new('Pablo', 'pand@email.pt', 'pablo123')
    @bet_ess.add_utilizador(utilizador)
    assert_equal(utilizador,@bet_ess.utilizadores['pand@email.pt'.to_sym])
  end

=begin
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
    @bet_ess.adicionar_quant(10,@utilizador)
    assert_equal(20,@bet_ess.utilizadores[@utilizador.email.to_sym])
  end


#TODO testes para os métodos em baixo:

=begin

  def adicionar_quant(quantia, apostador)
    apostador.adiciona_saldo(quantia)
  end

  def retirar_quant(quantia, apostador)
    apostador.remove_saldo(quantia)
  end

  def get_user (email)
    @utilizadores[email.to_sym]
  end

  def fechar_evento (id)
    eventos_abertos = get_eventos_abertos(@eventos)
    raise EventoInexistenteError, 'Evento inexistente ou já foi fechado anteriormente!' unless eventos_abertos.has_key?(id)

    evento = eventos_abertos[id]
    evento.fechar_evento
  end

  def concluir_evento (id, resultado)
    raise EventoInexistenteError, 'Evento inexistente, ainda aberto ou já concluído' unless @eventos.has_key?(id) && !@eventos[id].is_open && @eventos[id].resultado == Evento::EVENTO_NAO_CONCLUIDO
    evento = @eventos[id]
    evento.concluir_evento(resultado)
  end

  def registar_aposta(event, escolha, quantia, apostador)
    #apostador.regista_aposta(next_id_aposta, event, escolha, quantia)
    apostador.regista_aposta(@next_id_evento, event, escolha, quantia)
    #@next_id_aposta += 1
  end

  def get_evento_aberto(id)
    raise EventoInexistenteError, 'Não existe nenhum evento aberto com este identificador!' unless @eventos.has_key?(id) && @eventos[id].is_open
    @eventos[id]
  end

  def get_evento(id)
    raise EventoInexistenteError, 'Não existe nenhum evento com este identificador!' unless @eventos.has_key?(id)
    @eventos[id]
  end

  def mudar_odd(id_evento, odd_team1, odd_team2, odd_empate, bookie)
    evento = self.get_evento_aberto(id_evento)
    evento.mudar_odd(odd_team1, odd_team2, odd_empate, bookie)
  end

  def registar_interesse_em_evento(id_evento, bookie)
    eventos_nao_do_bookie_abertos = get_eventos_de_outros_bookies_abertos(@eventos, bookie)
    raise EventoInexistenteError, 'Não existe nenhum evento aberto para registar interesse com este identificador!' unless eventos_nao_do_bookie_abertos.has_key?(id_evento) && eventos_nao_do_bookie_abertos[id_evento].is_open
    evento = eventos_nao_do_bookie_abertos[id_evento]
    evento.add_observer(bookie)
  end
=end
end