require_relative '../Business/apostador'
require_relative '../Business/pesquisa'
require_relative '../Exceptions/utilizador_ja_existe_error'
require_relative '../Exceptions/utilizador_inexistente_error'
require_relative '../Exceptions/password_errada_error'
require_relative '../Business/evento'
require_relative '../Exceptions/evento_inexistente_error'

class BetESS
  attr_accessor :utilizadores, :eventos
  attr_reader :next_id_evento, :next_id_aposta, :saldo_inicial

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
    evento = Evento.new(@next_id_evento, equipa1, equipa2, odd1, odd_empate, odd2, true, desporto, hora_de_fecho, bookie)
    @eventos[evento.id] = evento
    @next_id_evento += 1
  end

  def adiciona_quant(quantia, apostador)
    apostador.adiciona_saldo(quantia)
  end

  def retira_quant(quantia, apostador)
    apostador.remove_saldo(quantia)
  end

  def get_user (email)
    @utilizadores[email.to_sym]
  end

  def fechar_evento (id)
    eventos_abertos = Pesquisa.get_eventos_abertos(@eventos)
    raise EventoInexistenteError, 'Evento inexistente ou já foi fechado anteriormente!' unless eventos_abertos.has_key?(id)

    evento = eventos_abertos[id]
    evento.fechar_evento
  end


  def registar_aposta(event, escolha, quantia, apostador)
    apostador.regista_aposta(next_id_aposta, event, escolha, quantia)
    @next_id_aposta += 1
  end

  def get_evento_aberto(id)
    raise EventoInexistenteException, 'Não existe nenhuma aposta aberta com este identificador!' unless @eventos.has_key?(id) && @eventos[id].is_open
    @eventos[id]
  end

end