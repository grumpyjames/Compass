require 'test/unit'
require '../test/fake_player.rb'
require '../test/fake_game.rb'
require '../impl/cancel_wrapper_action.rb'

class FakeWrappableAction
	OPTION = ["1","Option 1",""]
	QUESTION = "Would you like to know more?"

	def execute(board, player)
		@executed = true
		player.prompt(QUESTION, [OPTION])
	end
end

class TC_CancelWrapperAction < Test::Unit::TestCase
	def testAddsCancelOption
		fake_player = FakePlayer.new
		action_to_test = CancelWrapperAction.new(nil, FakeWrappableAction.new)
		action_to_test.execute(nil, fake_player)
		prompted_options = fake_player.options
		prompted_questions = fake_player.questions
		assert_equal(prompted_options[0][0], FakeWrappableAction::OPTION)
		assert_equal(prompted_questions[0], FakeWrappableAction::QUESTION)
		assert_equal(prompted_options[0][1], CancelWrapperAction::OPTION)
	end
end