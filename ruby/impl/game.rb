class Game

  def initialize(board, players)
    @board = board
    players.each do |player| player.add_to_game(self) end
    @players = players
  end
  
  def next_turn
    self.each_player( lambda {  |player| player.prompt("What do you want to do?",[["b","build"],["l","look"],["r","roll"],["p","play card"],["t","trade"]]) } )
  end
  
  def each_player(player_closure)
    @players.each do |player|
      player_closure.call(player)
    end
  end

end
