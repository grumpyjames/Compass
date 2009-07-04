class Game

  def initialize(board, players)
    @board = board
    players.each do |player| player.add_to_game(self) end
    @players = players
  end
  
  def next_turn
    @players.each do |player| 
      player.prompt("What do you want to do?",[["b","build"],["l","look"],["r","roll"],["p","play card"],["t","trade"]]) 
    end
  end

end
