class RobberAction
  def execute(game, player)
    game.each_player(lambda {|player| self.rob(player) })
  end

  def rob(player)
    puts player.resource_count
    if player.resource_count > 7
      player.discard
    end
  end
end
