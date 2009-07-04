require '../impl/resource.rb'

class Board
  def initialize(hex_builder, vertex_builder, edge_builder, config)
    @hex_builder = hex_builder
    @vertex_builder = vertex_builder
    @edge_builder = edge_builder
    config_lines = config.split("\n")
    @hexes = []
    config_lines.each do | config_line |
      @hexes.push(make_row(config_line, (@hexes.length + 1) % 2))
    end
  end

  def hex_at(row, column) #indexes start from 0
    @hexes[row][column]
  end
  
  def harvest(dice_score)
    @hexes.each do |row|
      row.each do |hex|
        if hex.trigger==dice_score
          hex.harvest
        end
      end
    end
  end
  
  def display
    @hexes.each do |row|
      this_row_out = ""
      row.each do |hex|
        this_row_out << hex.resource.to_s << "," << hex.trigger.to_s << " | "
      end
      puts this_row_out.strip.strip
    end
  end
  
  private
  def make_row(row_config, offset)
    split_config = row_config.split(":") #: separates resource types and associated dice rolls
    dice_rolls = split_config[1]==nil ? []:split_config[1].split(",")
    a_counter = 0
    @row_of_hexes = []
    last_hex = false
    split_config.first.split(",").each do |resource_key|
      resource = Resource::CONFIG_HASH[resource_key.downcase.to_sym]
      if !(Resource::BLANK_TYPES.include?(resource))
        trigger = dice_rolls[a_counter].to_i
        a_counter += 1		
      else
        trigger = 1
      end
      last_hex = generate_hex(resource, trigger, @row_of_hexes.last, offset) 
      @row_of_hexes.push(last_hex)
    end
    @row_of_hexes
  end
  
  def generate_hex(resource, trigger, last_hex, current_row_offset)
    new_vertices = []
    0.upto(5) do |i| new_vertices[i] = @vertex_builder.make_vertex end
    share_vertices_with_left_hex(last_hex, new_vertices)
    if @hexes.length > 0 # i.e there *is* a previous row
      share_vertices_from_previous_row(new_vertices, current_row_offset)
    end
    link_vertices(new_vertices, last_hex)
    @hex_builder.make_hex(new_vertices, resource, trigger) 
  end
  
  def link_vertices(new_vertices, last_hex)
    if !new_vertices[0].is_neighbour_of(new_vertices[1]) #checks for existing connection; say if we did this while building the previous row
      @edge_builder.make_edge(new_vertices[0], new_vertices[1])
    end
    if !new_vertices[0].is_neighbour_of(new_vertices[2])
      @edge_builder.make_edge(new_vertices[0], new_vertices[2])
    end
    @edge_builder.make_edge(new_vertices[2], new_vertices[4])
    @edge_builder.make_edge(new_vertices[3], new_vertices[5])
    @edge_builder.make_edge(new_vertices[4], new_vertices[5])
    if !last_hex
      @edge_builder.make_edge(new_vertices[1], new_vertices[3])
    end
  end
  
  def share_vertices_from_previous_row(new_vertices, offset)
    length_plus_offset = @row_of_hexes.length + offset
    if (length_plus_offset) > 0 #only for the first hex if we're offset
      up_and_left = @hexes.last[length_plus_offset - 1]
      new_vertices[1] = up_and_left[5] #upper left is bottom of above left
    end
    if (length_plus_offset) < @hexes.last.length #only for the last hex if we're not offset
      up_and_right = @hexes.last[length_plus_offset]
      new_vertices[0] = up_and_right[3]
      new_vertices[2] = up_and_right[5] #upper right is bottom of above right
    end
  end
  
  def share_vertices_with_left_hex(hex, new_vertices)
    if hex!=nil
      new_vertices[1] = hex[2]
      new_vertices[3] = hex[4]
    end
  end
  
end
