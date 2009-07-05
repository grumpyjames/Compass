require '../impl/root_choice_action.rb'

class RollAction
  def initialize(dice)
    @dice = dice
  end
  
  def execute(board, player)
    board.harvest(@dice.roll)
  end

  def result
    return RootChoiceAction.new
  end

end
