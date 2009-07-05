require '../impl/root_choice_action.rb'
require '../impl/robber_action.rb'

class RollAction
  
  def initialize(dice)
    @dice = dice
  end
  
  def execute(board, player)
    @last_score = @dice.roll
    if @last_score!=7
      board.harvest(@last_score)
    end
  end

  def result
    return @last_score!=7 ? RootChoiceAction.new : RobberAction.new
  end

end
