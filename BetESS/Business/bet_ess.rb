require_relative '../Business/apostador'
require_relative '../Business/pesquisa'
require_relative '../Exceptions/utilizador_ja_existe_error'
require_relative '../Exceptions/utilizador_inexistente_error'
require_relative '../Exceptions/password_errada_error'
class BetESS


  attr_accessor :search, :utilizadores, :eventos
  attr_reader :next_id_aposta, :saldo_inicial

  def initialize
      @utilizadores = Hash.new
      @eventos = Hash.new
      @search = Pesquisa.new
      @next_id_aposta = 1
      @saldo_inicial = 10
  end

  def add_utilizador(user)
    raise UtilizadorJaExisteError, 'Utilizador já existe' if @utilizadores.has_key?(user.email.to_sym)
    @utilizadores[user.email.to_sym] = user
  end

  def login(email, pwd)
    raise UtilizadorInexistenteError, 'Utilizador não registado' unless @utilizadores.has_key?(email.to_sym)
    u = utilizadores[email.to_sym]
    raise PasswordErradaError unless u.password == pwd
    u
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

end