require 'test/unit'
require '../test/fake_player.rb'
require '../test/fake_board.rb'
require '../test/fake_game.rb'
require '../impl/robber_action.rb'
require '../impl/resource.rb'

class TC_RobberAction < Test::Unit::TestCase
  
  def test_action_forces_discard
    robber_action = RobberAction.new
    fake_board = FakeBoard.new
    borderline = FakePlayer.new
    borderline.receive(Resource::WOOL, 2)
    borderline.receive(Resource::LUMBER, 3)
    borderline.receive(Resource::ORE, 1)
    borderline.receive(Resource::GRAIN, 1)
    borderline.receive(Resource::SETTLEMENT, 1)
    under = FakePlayer.new
    under.receive(Resource::WOOL, 6)
    over = FakePlayer.new
    over.receive(Resource::GRAIN, 5)
    over.receive(Resource::ORE, 3)
    fake_players = [borderline, under, over]
    fake_game = FakeGame.new(fake_players, fake_board)
    robber_action.execute(fake_game,fake_players[0])
    assert(!borderline.discarded)
    assert(!under.discarded)
    assert(over.discarded)
  end
  
end
