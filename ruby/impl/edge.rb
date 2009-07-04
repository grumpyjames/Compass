class Edge
  #todo - get constructor to call back the edges
  def initialize(head, tail)
    @head = head
    @tail = tail
    head.add_edge(self)
    tail.add_edge(self)
  end

  def has_vertex?(vertex)
    return vertex==@head || vertex==@tail
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def build( buildablelink ) #buildable link could be a road or a ship
    @building = buildablelink
  end

  def is_empty?
    return !@building
  end
end
