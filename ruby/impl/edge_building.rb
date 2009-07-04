class EdgeBuilding
  def initialize(edge, builder)
    raise ArgumentError, "Either edge or building player was nil" if !edge || !builder
    edge.build(self)
    @owner = builder
    @edge = edge
  end

  def owner
    @owner
  end
end
