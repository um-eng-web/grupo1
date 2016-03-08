require_relative '../Business/evento'
class ApostaUtilizador < Evento

  attr_accessor :quantia, :escolha, :data_aposta

  def initialize (event, quantia, escolha, data)
    super(event.id, event.team1, event.team2, event.odds_atuais.odd_team1, event.odds_atuais.odd_empate, event.odds_atuais.odd_team2, event.is_open, event.desporto, event.closing_time, event.bookie)
    @quantia = quantia
    @escolha = escolha
    @data_aposta = data
  end

  def to_s
    super.to_s + "\nData: #{@data_aposta.day}-#{@data_aposta.month}-#{@data_aposta.year}  #{@data_aposta.hour}:#{@data_aposta.min}\nEscolha: " +
    case(@escolha)
      when 0
        "\tEmpate"
        if @is_open
          "Ganho potencial: #{@quantia*@odds_atuais.odd_empate}"
        end
      when 1
        "#{@team1}"
        if @is_open
          "Ganho potencial: #{@quantia*@odds_atuais.odd_team1}"
        end
      else
        "#{@team2}"
        if @is_open
          "Ganho potencial: #{@quantia*team2}"
        end
    end
  end

end