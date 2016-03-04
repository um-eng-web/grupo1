require_relative '../Business/bet_ess'
require_relative '../Exceptions/utilizador_ja_existe_error'

class MenuPrincipal
  attr_accessor :bet_ess

  def initialize
    @bet_ess = BetESS.new
  end

  def menu_principal
    while true
        opt = menu_inicial
        puts opt
      case opt
        when '1'
            regista_user
        when '2'
            @bet_ess.login
        when '3'
            exit 0
        else
            puts 'Opção inválida!'

      end
    end

  end

  def menu_inicial
    puts '##############################     BetESS    ##############################'
    puts '#                                                                         #'
    puts '#   1 - Registar                                                          #'
    puts '#   2 - Login                                                             #'
    puts '#   3 - Sair da aplicação                                                 #'
    puts '#                                                                         #'
    puts '#   Escolha uma opção:                                                    #'
    puts '##########################################################################'
    opt = gets.chomp
    opt = menu_inicial unless opt == '1' || opt == '2' || opt == '3'
    opt
  end

  def regista_user
    puts '#################### Registar Utilizador #####################'
    puts
    puts '        Introduza o email de registo                    '
    email = gets.chomp
    puts '  Defina uma password                                   '
    pass = gets.chomp
    puts '  Defina um nickname                                    '
    nome = gets.chomp
    u = Apostador.new(@bet_ess.saldo_inicial, nome, email, pass)
    begin
      @bet_ess.add_utilizador(u)
      puts 'Registo efectuado com sucesso!'
      rescue UtilizadorJaExisteError
        puts 'Utilizador já se encontra registado'
    end
  end


end