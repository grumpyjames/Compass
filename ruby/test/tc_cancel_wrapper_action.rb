require 'test/unit'
require '../test/fake_player.rb'
require '../test/fake_game.rb'
require '../impl/cancel_wrapper_action.rb'

class FakeWrappableAction
	OPTION = ["1","Option 1",""]
	QUESTION = "Would you like to know more?"
	def execute(game, player)
		@executed = true
		player.prompt(QUESTION, [OPTION])
		player.false_method(self)
		@game = game
	end
	
	def game
		@game
	end
end

class TC_CancelWrapperAction < Test::Unit::TestCase
	def test_adds_cancel_option
		fake_player = FakePlayer.new
		action_to_test = CancelWrapperAction.new(nil, FakeWrappableAction.new)
		action_to_test.execute(nil, fake_player)
		prompted_options = fake_player.options
		prompted_questions = fake_player.questions
		assert_equal(prompted_options[0][0], FakeWrappableAction::OPTION)
		assert_equal(prompted_questions[0], FakeWrappableAction::QUESTION)
		assert_equal(prompted_options[0][1], CancelWrapperAction::OPTION)
	end
	
	def test_forwards_calls_to_player
		fake_player = FakePlayer.new
		fake_wrappable_action = FakeWrappableAction.new
		action_to_test = CancelWrapperAction.new(nil, fake_wrappable_action)
		action_to_test.execute(nil, fake_player)
		assert_equal(fake_wrappable_action,fake_player.false_method_caller)
	end
	
	def test_passes_game_object
		fake_game = FakeGame.new(nil, nil)
		fake_wrappable_action = FakeWrappableAction.new
		action_to_test = CancelWrapperAction.new(nil, fake_wrappable_action)
		action_to_test.execute(fake_game, FakePlayer.new)
		assert_equal(fake_game, fake_wrappable_action.game)
	end
	
end