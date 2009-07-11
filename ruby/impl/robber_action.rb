class RobberAction
  def execute(game, player)
    game.each_player(lambda { |player| player.discard })
  end
end
