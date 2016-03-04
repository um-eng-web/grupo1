require_relative '../Business/bookie'
require_relative '../Business/evento'
require_relative '../Business/bet_ess'
require_relative '../Menus/menu_principal'

class BookieMenu
  attr_reader :bet_ess, :bookie

  def initialize (bet_ess, bookie)
    @bet_ess = bet_ess
    @bookie = bookie
    @menu_principal = MenuPrincipal.new
  end

  def menu_bookie
    sair = 0
    puts '#############################     Bem vindo    ############################'
    puts '#                                                                         #'
    puts '#   1 - Inserir evento                                                    #'
    puts '#   2 - Listar eventos Abertas                                            #'
    puts '#   3 - Listar todos os eventos criados                                   #'
    puts '#   4 - Ver notificações (" + this.b.getNotificacoes().size() + ")         #'
    puts '#   5 - Registar interesse num evento                                    #'
    puts '#   6 - Alterar odds de um evento                                        #'
    puts '#   7 - Listar eventos criados abertas                                    #'
    puts '#   8 - Listar eventos criados fechadas                                   #'
    puts '#   0 - Sair                                                              #'
    puts '#                                                                         #'
    puts '#   Escolha uma opção:                                                    #'
    puts '##########################################################################"'
    opt = gets.chomp
    case opt
      when '1'; adicionar_evento
      when '2'; listar_eventos_abertas
      when '3'; listar_eventos_criados
      when '4'; ver_notificacoes
      when '5'; registar_interesse_em_evento
      when '6'; mudar_odds
      when '7'; listar_eventos_criados_abertos
      when '8'; listar_eventos_criados_fechados
      when '0'; sair = 1
      else puts 'Opção inválida!'
    end
    menu_bookie unless sair == 1
  end

  def adicionar_evento
    #begin
      puts 'Introduza o nome da primeira equipa:'
      eq1 = gets.chomp
      puts "Introduza a odd para a vitória desta equipa (#{eq1}):"
      odd1 = gets.chomp.to_f
      puts 'Introduza o nome da segunda equipa'
      eq2 = gets.chomp
      puts "Introduza a odd para a vitória desta equipa (#{eq2}):"
      odd2 = gets.chomp.to_f
      puts "Introduza a odd para o empate entre #{eq1} e #{eq2}:"
      odd_empate = gets.chomp.to_f
      puts 'Introduza a modalidade:'
      modalidade = gets.chomp
      puts 'Introduza o ano de fecho do evento:'
      ano = gets.chomp.to_i
      puts 'Introduza o mês de fecho do evento:'
      mes = gets.chomp.to_i
      puts 'Introduza o dia de fecho do evento:'
      dia = gets.chomp.to_i
      puts 'Introduza a hora de fecho do evento:'
      hora = gets.chomp.to_i
      puts 'Introduza o minuto de fecho do evento:'
      min = gets.chomp.to_i

      data = Time.new(ano, mes, dia, hora, min)
      @bet_ess = BetESS.new
      @bet_ess.add_evento(eq1, eq2, odd1, odd_empate, odd2, modalidade, data, @bookie)
     #rescue Error

    #end
  end

  def listar_eventos_criados_fechados
    # code here
  end

  def listar_eventos_criados_abertos
    # code here
  end

  def mudar_odds
    # code here
  end

  def registar_interesse_em_evento
    # code here
  end

  def ver_notificacoes
    # code here
  end

  def listar_eventos_criados
    # code here
  end

  def listar_eventos_abertas
    # code here
  end

end