require 'test/unit'
require '../test/fake_board.rb'
require '../test/fake_player.rb'
require '../impl/roll_action.rb'

class FakeDice
  def initialize(score)
    @score = score
  end
  def roll
    return @score
  end
end

class TC_RollAction < Test::Unit::TestCase
    
  #this will *not* test the randomness of the roll
  def test_roll_action_harvests
    roll_action = RollAction.new(FakeDice.new(8))
    fake_board = FakeBoard.new
    fake_player = FakePlayer.new
    roll_action.execute(fake_board, fake_player)
    assert(fake_board.harvested[0]==8, "RollAction should harvest with score of dice != 7")
  end

end
