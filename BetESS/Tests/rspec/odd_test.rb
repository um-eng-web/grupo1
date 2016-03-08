require 'minitest/autorun'
require_relative '../../Business/odd'

class OddTest < Minitest::Test

  def setup
    @data = Time.now
    @odd = Odd.new(1.01, 1.21, 2, @data)
  end

  def test_init_odd
    assert_equal(1.01, @odd.odd_team1)
    assert_equal(1.21, @odd.odd_empate)
    assert_equal(2, @odd.odd_team2)
    assert_equal(@data, @odd.data)
  end

end