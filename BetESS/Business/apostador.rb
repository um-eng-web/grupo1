require_relative '../Business/utilizador'
require_relative '../Exceptions/fundos_insuficientes_error'
require_relative '../Business/aposta_utilizador'
class Apostador < Utilizador
	attr_accessor :saldo, :lista_apostas, :notificacoes

    def initialize(saldo, nome, email, pwd)
      super(nome, email, pwd)
      @saldo = saldo
      @lista_apostas = Hash.new
      @notificacoes = Array.new
    end

  def adiciona_saldo(quantia)
    @saldo += quantia
  end

  def remove_saldo(quantia)
    raise FundosInsuficientesError, 'Não possui saldo suficiente' if @saldo < quantia
    @saldo -= quantia
  end

  def regista_aposta(id, event, escolha, quantia)
    raise FundosInsuficientesError, 'Lamentamos mas não tem saldo suficiente para realizar a operação' if @saldo < quantia
    aposta_user = ApostaUtilizador.new(event, quantia, escolha, Time.now)
    @lista_apostas[id] = aposta_user
    @saldo -= quantia
    ##ADD OBSERVER
  end


	end