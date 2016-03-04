class ApostaUtilizador < Evento

  attr_accessor :quantia, :escolha, :data_aposta

  def initialize (evento, quantia, escolha, data)
    super(evento)
    @quantia = quantia
    @escolha = escolha
    @data = data
  end
end