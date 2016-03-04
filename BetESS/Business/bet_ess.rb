require_relative '../Business/apostador'
require_relative '../Business/pesquisa'
require_relative '../Exceptions/utilizador_ja_existe_error'
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


end