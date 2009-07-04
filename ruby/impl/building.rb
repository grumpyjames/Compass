#don't put too much functionality in here if you can avoid doing so
class Building
  def initialize(type, builder, vertex)
    raise RuntimeError, 'Nil constructor argument provided' if !type || !builder || !vertex
    vertex.build(self)
    @type = type
    @owner = builder
  end
  def owner
    @owner
  end
  def accept (resource)
    @owner.receive(resource, @type)
  end
  def type
    @type
  end
end
