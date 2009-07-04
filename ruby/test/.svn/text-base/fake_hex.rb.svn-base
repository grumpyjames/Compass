class FakeHex
  def initialize(resource, score, vertices)
    @resource = resource
    @trigger = score
    @vertices = vertices
    @harvest_count = 0
  end
  
  def blank?
    Resource::BLANK_TYPES.include?(@resource)
  end

  def resource
    @resource
  end

  def trigger
    @trigger
  end

  def harvest
    @harvest_count += 1
    @vertices.each do |vertex|
      vertex.distribute(@resource)
    end
  end
  
  def harvest_count
    @harvest_count
  end
  
  def [] (index)
    return @vertices[index]
  end

  #convenience functions
  def top
    @vertices[0]
  end
  
  def upper_left
    @vertices[1]
  end

  def upper_right
    @vertices[2]
  end

  def lower_left
    @vertices[3]
  end

  def lower_right
    @vertices[4]
  end

  def bottom
    @vertices[5]
  end

  def vertices
    @vertices
  end
  
  def has_vertex(a_vertex)
    @vertices.include?(a_vertex)
  end

end
