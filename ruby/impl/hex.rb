class Hex
  
  @vertices
  @resource
  
  def initialize( vertices, resource, trigger )
    raise ArgumentError, 'nil trigger passed. Baad.' if !trigger
    @vertices = vertices
    @vertices.each do |vertex| vertex.add_hex(self) end
    @resource = resource
    @trigger = trigger
  end
  
  def trigger
    @trigger
  end
  
  def has_vertex? (vertex)
    @vertices.include?(vertex)
  end
  
  def harvest
    if @robber
      return
    end
    @vertices.each do |vertex|
      vertex.distribute(@resource)
    end
  end
  
  def resource
    @resource
  end

  def place_robber
    raise RuntimeError,'Robber already here' if @robber
    @robber=true
  end

  def remove_robber
    @robber=false
  end

  def blank?
    Resource::BLANK_TYPES.include?(@resource)
  end
  
  def [] (index)
    @vertices[index]
  end
  
  def edge_connecting (head_vertex_index, tail_vertex_index)
    @vertices[head_vertex_index].get_connection_to(@vertices[tail_vertex_index])
  end

  def to_s
    "Res: " + Resource::NAMES[@resource].to_s.capitalize + ", Trig: " + @trigger.to_s
  end
  
end
