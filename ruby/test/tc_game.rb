require 'test/unit'
require '../test/fake_player.rb'
require '../impl/game.rb'
require '../impl/resource.rb'
require '../test/fake_board.rb'

class TC_Game < Test::Unit::TestCase

  def test_player_callback_and_board_storage
    fake_player = FakePlayer.new
    fake_board = FakeBoard.new
    game = Game.new(fake_board, [fake_player])
    assert(fake_player.game == game)
  end
  
  def test_prompts_player_correctly_at_start_of_turn
    fake_player = FakePlayer.new
    game = Game.new(FakeBoard.new, [fake_player])
    game.next_turn
    assert(fake_player.prompted)
  end
  
  def test_each_player
    players = []
    0.upto(3) do |index|
      players.push(FakePlayer.new)
    end
    game = Game.new(FakeBoard.new, players)
    player_closure = lambda { |player| player.receive(Resource::WOOL,1) }
    game.each_player(player_closure)
    expected_resources = Hash.new(0)
    expected_resources[Resource::WOOL] = 1
    players.each do |player|
      assert(player.resources==expected_resources,"Should have one wool due to closure execution")
    end
  end

end
