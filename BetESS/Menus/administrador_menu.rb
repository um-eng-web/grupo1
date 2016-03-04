require_relative '../Business/bookie'
require_relative '../Exceptions/utilizador_ja_existe_error'
require_relative '../Business/pesquisa'
require_relative '../Business/bet_ess'
require_relative '../Menus/aux_print'
require_relative '../Exceptions/evento_inexistente_error'

class AdministradorMenu
  attr_reader :bet_ess, :admin

  def initialize (bet_ess, admin)
    @bet_ess = bet_ess
    @admin = admin
  end

  def fechar_evento
    eventos_abertos = Pesquisa.get_eventos_abertos(@bet_ess.eventos)
    AuxPrint.listar(eventos_abertos)
    unless eventos_abertos.empty?
      puts '###########################################################################'
      puts '#                                                                         #'
      puts '#   Por favor introduza o id correspondente ao evento a fechar            #'
      puts '#                                                                         #'
      puts '###########################################################################'
      id = gets.chomp.to_i
      begin
        @bet_ess.fechar_evento(id)
      rescue EventoInexistenteError => e
        puts e.message
      end
    end
  end

  def concluir_evento
    eventos_fechados = Pesquisa.get_eventos_fechados(@bet_ess.eventos)
    AuxPrint.listar(eventos_fechados)
    unless eventos_fechados.empty?
      puts '###########################################################################'
      puts '#                                                                         #'
      puts '#   Por favor introduza o id correspondente ao evento a concluir          #'
      puts '#                                                                         #'
      puts '###########################################################################'
      id = gets.chomp.to_i
      puts '###########################################################################'
      puts '#                                                                         #'
      puts '#                    Por favor introduza resultado                        #'
      puts '#       0 - Empate, 1 - Vitória da Equipa1, 2 - Vitória da Equipa2         #'
      puts '#                                                                         #'
      puts '###########################################################################'
      resultado = gets.chomp.to_i
      begin
        @bet_ess.concluir_evento(id, resultado)
      rescue EventoInexistenteError => e
        puts e.message
      end
    end
  end

  def registar_bookie
    puts '#################### Registar Bookie ###################'
    puts '                                                        '
    puts '   Introduza o email de registo'
    email = gets.chomp
    puts '   Defina uma password'
    pw = gets.chomp
    puts '   Defina um username'
    user = gets.chomp

    bookie = Bookie.new(user, email, pw)
    begin
      @bet_ess.add_utilizador(bookie)
      puts 'Registo efetuado com sucesso!'
    rescue UtilizadorJaExisteError => e
      puts "#{e.message}"
    end
  end

  def menu_administrador
    sair = 0
    puts '#############################     Bem vindo    ############################'
    puts '#                                                                         #'
    puts '#   1 - Fechar Aposta                                                     #'
    puts '#   2 - Concluir Aposta                                                   #'
    puts '#   3 - Registar Novo Bookie                                              #'
    puts '#   0 - Sair                                                              #'
    puts '#                                                                         #'
    puts '#   Escolha uma opção:                                                    #'
    puts '###########################################################################'
    opt = gets.chomp
    case opt
      when '1'; self.fechar_evento
      when '2'; self.concluir_evento
      when '3'; self.registar_bookie
      when '0'; sair = 1
      else puts 'Opção inválida!'
    end

    self.menu_administrador unless sair == 1
  end
end