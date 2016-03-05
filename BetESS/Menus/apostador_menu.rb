require_relative '../Business/bet_ess'
require_relative '../Business/pesquisa'
require_relative '../Menus/aux_print'
require_relative '../Exceptions/evento_inexistente_error'
require_relative '../Exceptions/fundos_insuficientes_error'
require_relative '../Business/pesquisa'
class ApostadorMenu
  attr_accessor :bet_ess, :apostador

  def initialize(bet_ess, apostador)
    @bet_ess = bet_ess
    @apostador =  apostador
  end

  def menu_apostador
    sair = 0
    while sair != 1
      puts "#######################   Utilizador: #{apostador.nome} Saldo: #{apostador.saldo}    #########################"
      puts '#                                                                         #'
      puts '#   1 - Apostar                                                           #'
      puts '#   2 - Listar Apostas Abertas Pessoais                                   #'
      puts '#   3 - Listar Todas as Apostas Pessoais                                  #'
      puts '#   4 - Adicionar crédito                                                 #'
      puts '#   5 - Levantar crédito                                                  #'
      puts "#   6 - Ver notificações (#{apostador.notificacoes.size})                                       #"
      puts '#                                                                         #'
      puts '#   0 - Sair                                                              #'
      puts '#                                                                         #'
      puts '#   Escolha uma opção:                                                    #'
      puts '##########################################################################'
      op = gets.chomp
      case op
        when '1'
          menu_aposta
        when '2'
          AuxPrint.listar(@bet_ess.get_apostas_abertas_apostador(@apostador.lista_apostas))
        when '3'
          AuxPrint.listar(@apostador.lista_apostas)
        when '4'
          depositar_quant
        when '5'
          levantar_quant
        when '6'
          ver_notificacoes
        when '0'
          sair = 1
        else
          puts 'Opção inválida'
      end
        #@apostador = @bet_ess.get_user(@apostador.email)
    end
  end

  def depositar_quant
    puts '###########################################################################'
    puts '#                                                                         #'
    puts '#   Por favor introduza a quantia a depositar                             #'
    puts '#                                                                         #'
    puts '###########################################################################'
    q = gets.chomp.to_f
    @bet_ess.adicionar_quant(q, @apostador)
    puts '#########        Saldo atualizado com sucesso        #########'
  end
  def levantar_quant
    puts '###########################################################################'
    puts '#                                                                         #'
    puts '#   Por favor introduza a quantia a levantar                              #'
    puts '#                                                                         #'
    puts '###########################################################################'
    q = gets.chomp.to_f
    begin
      @bet_ess.retirar_quant(q, @apostador)
      puts '#########        Saldo atualizado com sucesso        #########'
    rescue FundosInsuficientesError => e
      puts e.message
    end
  end

  def menu_aposta
    puts '##############################   Aposta   #################################'
    listagem = @bet_ess.get_eventos_abertos(@bet_ess.eventos)
      AuxPrint.listar(listagem)
      unless listagem.empty?
        puts '#                                                                         #'
        puts '#   Por favor introduza o id correspondente à aposta                      #'
        puts '#                                                                         #'
        puts '###########################################################################'
        id = gets.chomp.to_i
        begin
          event = @bet_ess.get_evento_aberto(id)
          opt_fora_de_intervalo = false
          escolha = -1
          while escolha <0 || escolha >2
            if opt_fora_de_intervalo
              puts 'Introduza uma seleção válida!'
            else
              puts event.to_s
              puts '##############################   Aposta   #################################'
              puts '#                                                                         #'
              puts '#   Por favor introduza a opção:                                          #'
              puts '#       0- Empate                                                         #'
              puts "#       1-  #{event.team1}                                               #"
              puts "#       2-  #{event.team2}                                               #"
              puts '#                                                                         #'
              puts '###########################################################################'
              escolha = gets.chomp.to_i
              opt_fora_de_intervalo = escolha < 0 || escolha > 2;
            end
          end
          puts '##############################   Aposta   #################################'
          puts '#                                                                         #'
          puts '#   Por favor introduza a quantia que deseja apostar                      #'
          puts '#                                                                         #'
          puts '###########################################################################'
          quantia = gets.chomp.to_f
          @bet_ess.registar_aposta(event, escolha, quantia, @apostador)
          puts '#######################     Aposta efetuada!        #######################'
          rescue FundosInsuficientesError, EventoInexistenteError => e
            puts e.message
        end
    end
  end

  def ver_notificacoes
    unless @apostador.notificacoes.empty?
      puts '####################        Notificações        ###########################'
      @apostador.notificacoes.each { |n| puts n.to_s_apostador(@bet_ess.get_evento(n.id_evento)) }
      @apostador.notificacoes.clear
    end
  end

end

