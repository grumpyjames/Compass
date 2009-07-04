require 'test/unit'
require '../test/fake_player.rb'
require '../impl/game.rb'
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

end