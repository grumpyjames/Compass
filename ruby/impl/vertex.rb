class Vertex
  def initialize(modifiers = [])
    @building = false
    @edges = Array.new()
    @hexes = Array.new()
    @modifiers = modifiers
  end

  def add_hex(hex)
    @hexes.push(hex)
  end

  def build(building)
    @building = building
    self
  end

  def distribute(resource)
    if !is_empty?
      @building.receive(resource)
    end
  end

  def is_empty?()
    !!!@building
  end

  def add_edge ( edge )
    raise ArgumentError,"Can't add edge to vertex that does not contain it" if self!=edge.head && self!=edge.tail
    @edges << edge
    self
  end

  def edges
    @edges.length
  end

  def is_neighbour_of ( vertex )
    @edges.each do |edge|
      if edge.head==vertex || edge.tail==vertex
        return true
      end
    end
    return false
  end

  def is_buildable_on?
    if !is_empty?
      return false
    else
      @edges.each do |edge|
        if !edge.head.is_empty? || !edge.tail.is_empty?
          return false
        end
      end
      return self.interesting?
    end
  end

  def interesting?
    @hexes.each do |hex| #vertex must have a land based hex to be buildable on
      if hex.resource!=Resource::BLANK && hex.resource!=Resource::SEA
        return true
      end
    end
    false
  end

  def has_modifiers?
    return @modifiers.length > 0
  end
  
  def get_connection_to(a_vertex)
    @edges.each do |edge|
      if edge.head == a_vertex || edge.tail == a_vertex
        return edge
      end
    end
  end
  
  def in_network_of(player)
    @edges.each do |edge|
      if edge.building && edge.building.owner==player
        return true
      end
    end
    false
  end
  
end
