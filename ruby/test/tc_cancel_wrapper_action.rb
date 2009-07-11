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
		@executed = true
	end
	
	def executed
		@executed
	end
	
	def game
		@game
	end
	
	def cancel
		@cancelled = true
	end
	
	def cancelled
		@cancelled
	end
	
end

class SimpleFakeAction
	def execute(game,player)
		@game = game
		@player = player
		@executed = true
	end
	
	def game
		@game
	end
	
	def player
		@player
	end
	
	def executed
		@executed
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
	
	def test_intercepts_cancel_response_and_acts_appropriately
		fake_player = FakePlayer.new
		fake_game = FakeGame.new(nil, nil)
		fake_player.add_response(CancelWrapperAction::CANCEL_RESPONSE)
		fake_wrappable_action = FakeWrappableAction.new
		last_executed_action = SimpleFakeAction.new
		action_to_test = CancelWrapperAction.new(last_executed_action, fake_wrappable_action)
		assert_equal(nil, last_executed_action.game)
		assert_equal(nil, last_executed_action.player)
		action_to_test.execute(fake_game, fake_player)
		assert(fake_wrappable_action.cancelled, "cancel response should cancel wrapped action")
		assert_equal(fake_game, last_executed_action.game)
		assert_equal(fake_player, last_executed_action.player) #we don't want to wrap the last action's player
		assert(last_executed_action.executed)
	end
	
end