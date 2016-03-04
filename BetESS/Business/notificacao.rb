class Notificacao
  attr_accessor :id_aposta, :quantia_ganha, :descricao

  def initialize (id_aposta, quantia_ganha, descricao)
    @if_aposta = id_aposta
    @quantia_ganha = quantia_ganha
    @descricao = descricao
  end
end
