require '../impl/player.rb'

class CancelWrapperAction #implements BaseAction, Player

	OPTION = ["C","Cancel this action",""]
	def initialize(previous_action, current_cancellable_action)
		@previous_action = previous_action
		@wrapped_action = current_cancellable_action
	end
	
	def execute(board, player)
		@wrapped_player = player
		@wrapped_action.execute(board, self)
	end
	
	def prompt(question, options)
		options.push(OPTION)
		@wrapped_player.prompt(question, options)
	end
	
	def method_missing(sym, *args, &block)
		begin
			@wrapped_player.send sym, *args, &block
		rescue NoMethodError
			raise NoMethodError,"tried to forward request to player that it doesn't respond to"
		end
	end
	
end