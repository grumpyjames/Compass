require 'test/unit'
require '../test/fake_player.rb'
require '../test/fake_board.rb'
require '../test/fake_game.rb'
require '../impl/robber_action.rb'

class TC_RobberAction < Test::Unit::TestCase
  
  def test_action_forces_discard
    robber_action = RobberAction.new
    fake_board = FakeBoard.new
    fake_players = []
    0.upto(3) do |index|
      fake_players.push(FakePlayer.new)
    end
    fake_game = FakeGame.new(fake_players, fake_board)
    robber_action.execute(fake_game,fake_players[0])
    fake_players.each do |player|
      assert(player.discarded, "Players should have been asked to discard")
    end
  end
  
end
