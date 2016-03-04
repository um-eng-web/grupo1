require_relative '../Business/utilizador'
require_relative '../Exceptions/fundos_insuficientes_error'
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

	end