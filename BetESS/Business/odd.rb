class Odd
  attr_accessor :odd_team1, :odd_empate, :odd_team2, :data



  def initialize (odd_team1, odd_empate, odd_team2, data)
    @odd_team1, @odd_empate, @odd_team2 = odd_team1, odd_empate, odd_team2
    @data = data
  end
end