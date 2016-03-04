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
        sair = 1
      else
        puts 'Opção inválida'
    end
    menu_apostador unless sair ==1
      #@apostador = @bet_ess.get_user(@apostador.email)
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

  def menu_aposta
    puts '##############################   Aposta   #################################'

  end


  private void menuAposta() {
    System.out.println("##############################   Aposta   #################################");
    TreeMap<BetKey, Evento> listagem;
+    listagem = (TreeMap) this.p.getEventosAbertos((TreeMap<BetKey, Evento>) betEss.getEventos());
    if (listagem.isEmpty()) {
        System.out.println();
    System.out.println("Não existem quaisquer apostas abertas");
    System.out.println();
    } else {
        AuxPrint.listarApostasAbertas(listagem);
    System.out.println("##############################   Aposta   #################################");
    System.out.println("#                                                                         #");
    System.out.println("#   Por favor introduza o id correspondente à aposta                      #");
    System.out.println("#                                                                         #");
    System.out.println("###########################################################################");
    String opt = in.next();
    int idAposta = Integer.parseInt(opt);
    try {
      Evento a = betEss.getEventoAberto(idAposta);
      boolean optOutOfRange = false;
      int escolha = -1;
      while (escolha < 0 || escolha > 2) {
          if (optOutOfRange) {
              System.err.println("Introduza uma seleção válida!");
          }
          System.out.println(a.toString());
          System.out.println("##############################   Aposta   #################################");
          System.out.println("#                                                                         #");
          System.out.println("#   Por favor introduza a opção:                                          #");
          System.out.println("#       0- Empate                                                          #");
          System.out.println("#       1- " + a.getTeam1() + "                                            #");
          System.out.println("#       2- " + a.getTeam2() + "                                            #");
          System.out.println("#                                                                         #");
          System.out.println("###########################################################################");
          opt = in.next();
          escolha = Integer.parseInt(opt);
          optOutOfRange = escolha < 0 || escolha > 2;
          }
          System.out.println("##############################   Aposta   #################################");
          System.out.println("#                                                                         #");
          System.out.println("#   Por favor introduza a quantia que deseja apostar                      #");
          System.out.println("#                                                                         #");
          System.out.println("###########################################################################");
          double quant = in.nextDouble();
          betEss.registaAposta(a, escolha, quant, this.a);
          System.out.println("###########     Aposta efetuada!        ##########");
          } catch (NotEnoughMoneyException | EventoInexistenteException err) {
            System.err.println(err.getMessage());
          }
          }

          }


end