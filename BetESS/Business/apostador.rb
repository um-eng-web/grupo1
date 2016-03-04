require_relative '../Business/utilizador'
class Apostador < Utilizador
	attr_accessor :saldo, :lista_apostas, :notificacoes

    def initialize(saldo, nome, email, pwd)
      super(nome, email, pwd)
      @saldo = saldo
      @lista_apostas = Hash.new
      @notificacoes = Array.new
    end
	end