class RollAction
  def initialize(dice)
    @dice = dice
  end
  
  def execute(board, player)
    board.harvest(@dice.roll)
  end

end
