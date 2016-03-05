require_relative '../Business/apostador'
require_relative '../Business/pesquisa'
require_relative '../Exceptions/utilizador_ja_existe_error'
require_relative '../Exceptions/utilizador_inexistente_error'
require_relative '../Exceptions/password_errada_error'
require_relative '../Business/evento'
require_relative '../Exceptions/evento_inexistente_error'

class BetESS
  SALDO_INICIAL = 10
  attr_accessor :utilizadores, :eventos
  attr_reader :next_id_evento, :next_id_aposta, :saldo_inicial
  include(Pesquisa)
  def initialize
      @utilizadores = Hash.new
      @eventos = Hash.new
      #@search = Pesquisa.new
      @next_id_aposta = 1
      @next_id_evento = 1
      @saldo_inicial = 10
  end

  def add_utilizador(user)
    raise UtilizadorJaExisteError, 'Utilizador já existe' if @utilizadores.has_key?(user.email.to_sym)
    @utilizadores[user.email.to_sym] = user
  end

  def login(email, pwd)
    raise UtilizadorInexistenteError, 'Utilizador não registado' unless @utilizadores.has_key?(email.to_sym)
    u = utilizadores[email.to_sym]
    raise PasswordErradaError, 'Password incorreta' unless u.password == pwd
    u
  end

  def add_evento(equipa1, equipa2, odd1, odd_empate, odd2, desporto, hora_de_fecho, bookie)
    evento = Evento.new(@next_id_evento, equipa1.upcase, equipa2.upcase, odd1, odd_empate, odd2, true, desporto.upcase, hora_de_fecho, bookie)
    @eventos[evento.id] = evento
    @next_id_evento += 1
  end

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
end