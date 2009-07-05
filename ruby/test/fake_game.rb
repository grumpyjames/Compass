class FakeGame

  def initialize(players,board)
    @players = players
    @board = board
  end

  def board
    @board
  end
  
  def each_player(player_closure)
    @players.each do | player |
      player_closure.call(player)
    end
  end
  
end
