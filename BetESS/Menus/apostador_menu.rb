require_relative '../Business/bet_ess'
class ApostadorMenu
  attr_accessor :bet_ess, :apostador, :search

  def initialize(bet_ess, apostador)
    @bet_ess = bet_ess
    @apostador =  apostador
    @search = Pesquisa.new()
  end

  def menu_apostador
    sair = 0
    puts "#######################   Utilizador: #{apostador.nome} Saldo: #{apostador.saldo}    #########################"
    puts '#                                                                         #'
    puts '#   1 - Apostar                                                           #'
    puts '#   2 - Listar Apostas Abertas Pessoais                                   #'
    puts '#   3 - Listar Todas as Apostas Pessoais                                  #'
    puts '#   4 - Adicionar crédito                                                 #'
    puts '#   5 - Levantar crédito                                                  #'
    puts "#   6 - Ver notificações (#{apostador.notificacoes.size})                                    #"
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
        lista_aposta_abertas_pessoais
      when '3'
        lista_apostas_pessoais
      when '4'
        depositar_quant
      when '5'
        levantar_quant
      when '6'
        ver_notificacoes
      when '0'
        sair = 0
        mp = MenuPrincipal.new
        mp.menu_principal
      else
        puts 'Opção inválida'
    end
    if sair!=1
      @apostador = @bet_ess.get_user(@apostador.email)
      menu_apostador
    end
  end

  def depositar_quant
    puts '###########################################################################'
    puts '#                                                                         #'
    puts '#   Por favor introduza a quantia a depositar                             #'
    puts '#                                                                         #'
    puts '###########################################################################'
    q = gets.chomp.to_f
    @bet_ess.adiciona_quant(q,@apostador)
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
      @bet_ess.retira_quant(q, @apostador)
      puts '#########        Saldo atualizado com sucesso        #########'
    rescue FundosInsuficientesError => e
      puts e.message
    end
  end



end