require_relative '../Business/utilizador'
require_relative '../Exceptions/fundos_insuficientes_error'
require_relative '../Business/aposta_utilizador'
require_relative '../Business/evento'
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
    event.add_observer(self)
  end

  def update(evento, tipo)
    puts 'UPPPPPPPPPPPPPPPPPPPPPPPPPPDATEEEEEEEEEEEE'
    if tipo == Evento::CONCLUIR_EVENTO
      puts 'Evento concluido'
      aposta_utilizador = @lista_apostas[evento.id]
      result = evento.resultado
      escolha = aposta_utilizador.escolha
      if escolha == result
        case result
          when Evento::EMPATE
            q = aposta_utilizador.quantia * aposta_utilizador.odd_atuais.odd_empate
          when Evento::EQUIPA1
            q = aposta_utilizador.quantia * aposta_utilizador.odd_atuais.odd_team1
          else
            q = aposta_utilizador.quantia * aposta_utilizador.odd_atuais.odd_team2
        end
        @saldo += q
        descricao = 'Parabéns, GANHASTE esta aposta!'
      else
        descricao = 'PERDESTE esta aposta, tenta outra vez!'
      end
      n = Notificacao(evento.id, q, descricao)
      @notificacoes.push(n)
    end
  end

	end