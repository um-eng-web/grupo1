require_relative '../Business/bet_ess'
require_relative '../Exceptions/utilizador_ja_existe_error'
require_relative '../Menus/administrador_menu'
require_relative '../Menus/bookie_menu'
require_relative '../Menus/apostador_menu'
require_relative '../Exceptions/utilizador_inexistente_error'
require_relative '../Exceptions/password_errada_error'
require_relative '../Business/administrador'
require_relative '../Business/bookie'
require_relative '../Business/apostador'
require_relative '../Business/pesquisa'
require_relative '../Business/evento'

class MenuPrincipal
  attr_accessor :bet_ess

  def initialize
    @bet_ess = BetESS.new
    @bet_ess.add_utilizador(Administrador.new('123', '123', '123'))
    b1 = Bookie.new('b1', 'b1', 'b1')
    @bet_ess.add_utilizador(b1)
    b2 = Bookie.new('b2', 'b2', 'b2')
    @bet_ess.add_utilizador(b2)
    a1 = Apostador.new('a1', 'a1', 'a1')
    @bet_ess.add_utilizador(a1)
    @bet_ess.add_evento("FC Porto", "SL Benfica", 1.01, 1.21, 200.0, "Futebol", Time.now, b1)
    @bet_ess.add_evento("SC Braga", "Sporting CP", 1.01, 1.21, 200.0, "Futebol", Time.now, b1)
    @bet_ess.add_evento("Vitoria", "Belenenses", 200, 1.21, 1.01, "Futebol", Time.now, b2)
  end

  def menu_principal
    while true
        opt = menu_inicial
        puts opt
      case opt
        when '1'
            regista_user
        when '2'
            login
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
      rescue UtilizadorJaExisteError  => e
        puts e.message
    end
  end

  def login
    puts '##################### Login  ##########################'
    puts
    puts '   Introduza o email                                    '
    email = gets.chomp
    puts '   Introduza a password                                 '
    pwd = gets.chomp
    begin
      u = bet_ess.login(email, pwd)
      if u.is_a? Apostador
        am = ApostadorMenu.new(@bet_ess, u)
        am.menu_apostador
      elsif u.is_a? Bookie
        bm = BookieMenu.new(@bet_ess, u)
        bm.menu_bookie
      else u.is_a? Administrador
        adm = AdministradorMenu.new(@bet_ess, u)
        adm.menu_administrador
      end
    rescue UtilizadorInexistenteError, PasswordErradaError => e
      puts e.message
    end
  end

end