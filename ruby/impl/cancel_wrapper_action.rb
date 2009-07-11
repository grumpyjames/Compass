require '../impl/player.rb'

class CancelException < Exception
	def initialize(message)
		@message = message
	end
	
	def message
		@message
	end	
end

class CancelWrapperAction #implements BaseAction, Player
	CANCEL_RESPONSE = "C"
	OPTION = [CANCEL_RESPONSE,"Cancel this action",""]
	def initialize(previous_action, current_cancellable_action)
		@previous_action = previous_action
		@wrapped_action = current_cancellable_action
	end
	
	def execute(board, player)
		@wrapped_player = player
		begin
			@wrapped_action.execute(board, self)
		rescue CancelException #we're throwing a cancel exception at the wrapped action to stop it: see below
			@previous_action.execute(board, player)
		end
	end
	
	def prompt(question, options)
		options.push(OPTION)
		response = @wrapped_player.prompt(question, options)
		if response==CANCEL_RESPONSE
			@wrapped_action.cancel
			raise CancelException.new("This action has been cancelled. This exception should be caught by the wrapper")
		end
		response
	end
	
	def method_missing(sym, *args, &block)
		begin
			@wrapped_player.send sym, *args, &block
		rescue NoMethodError
			raise NoMethodError,"tried to forward request to player that it doesn't respond to"
		end
	end
	
end