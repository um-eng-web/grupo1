require_relative '../Business/bookie'
require_relative '../Exceptions/utilizador_ja_existe_error'
class AdministradorMenu
  attr_reader :bet_ess, :search, :admin

  def initialize
    @bet_ess = bet_ess
    @admin = admin
    @search = search
  end

  def fechar_aposta
    
  end

  def concluir_aposta

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
      when '1'; self.fechar_aposta
      when '2'; self.concluir_aposta
      when '3'; self.registar_bookie
      when '0'; sair = 1
      else puts 'Opção inválida!'
    end

    self.menu_administrador unless sair == 1
  end
end