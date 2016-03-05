require_relative '../Business/bookie'
require_relative '../Business/evento'
require_relative '../Business/bet_ess'
require_relative '../Menus/menu_principal'
require_relative '../Business/pesquisa'
require_relative '../Menus/aux_print'

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
    puts "#   4 - Ver notificações (#{@bookie.notificacoes.size})                        #"
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
    eventos_criados_fechados = @bet_ess.get_eventos_do_bookie_fechados(@bet_ess.eventos, @bookie)
    AuxPrint.listar(eventos_criados_fechados)
  end

  def listar_eventos_criados_abertos
    eventos_criados_abertos = @bet_ess.get_eventos_do_bookie_abertos(@bet_ess.eventos, @bookie)
    AuxPrint.listar(eventos_criados_abertos)
  end

  def mudar_odds
    eventos_criados_abertos = @bet_ess.get_eventos_do_bookie_abertos(@bet_ess.eventos, @bookie)
    AuxPrint.listar(eventos_criados_abertos)
    unless eventos_criados_abertos.empty?
      begin
        puts '###########################################################################'
        puts '#                                                                         #'
        puts '#   Por favor introduza o id correspondente ao evento a alterar           #'
        puts '#                                                                         #'
        puts '###########################################################################'
        id = gets.chomp.to_i
        evento = @bet_ess.get_evento_aberto(id)
        self.set_new_odd(evento)
      rescue EventoInexistenteError => e
        puts e.message
      end
    end
  end

  def set_new_odd(evento)
    begin
      puts "Introduza a odd (X,XX) para a vitória da equipa1 (#{evento.team1}):"
      odd1 = gets.chomp.to_f
      puts "Introduza a odd (X,XX) para a vitória da equipa2 (#{evento.team2}):"
      odd2 = gets.chomp.to_f
      puts 'Introduza a odd (X,XX) para o empate entre as duas equipas:'
      odd_empate = gets.chomp.to_f
      @bet_ess.mudar_odd(evento.id, odd1, odd2, odd_empate, @bookie)
    end
  end

  def registar_interesse_em_evento
    eventos_de_outros_bookies_abertos = @bet_ess.get_eventos_de_outros_bookies_abertos(@bet_ess.eventos, @bookie)
    AuxPrint.listar(eventos_de_outros_bookies_abertos, 'Não existem eventos para registar interesse')
    unless eventos_de_outros_bookies_abertos.is_empty?
      begin
        puts '###########################################################################'
        puts '#                                                                         #'
        puts '#   Por favor introduza o id correspondente ao evento a alterar           #'
        puts '#                                                                         #'
        puts '###########################################################################'
        id = gets.chomp.to_i
        @bet_ess.registar_interesse_em_evento(id, @bookie)
      rescue EventoInexistenteError => e
        puts e.message
      end
    end
  end

  def ver_notificacoes
    unless @bookie.notificacoes.empty?
      puts '####################        Notificações        ###########################'
      @bookie.notificacoes.each { |n| puts n.to_s(@bet_ess.get_evento(n.id_evento)) }
      @bookie.notificacoes.clear
    end
  end

  def listar_eventos_criados
    eventos_criados = @bet_ess.get_eventos_do_bookie(@bet_ess.eventos, @bookie)
    AuxPrint.listar(eventos_criados)
  end

  def listar_eventos_abertas
    eventos_abertos = @bet_ess.get_eventos_abertos(@bet_ess.eventos)
    AuxPrint.listar(eventos_abertos)
  end

end