 # Fake vertex implementation for testing
 class FakeVertex
   # Initializes the fake with no hexes, vertices, resources or networks
   def initialize
     @harvested = Hash.new(0) #keys are resource types, values are numbers of that resource distributed to this vertex            
     @hexes = []
     @edges = []
     @networks = Hash.new(false)
   end
   # Does not actually distribute, merely holds a record of what has been distributed to it
   def distribute( resource ) # of type resource
     @harvested[resource] += 1
   end
   # Accessor for harvested
   def harvested
     @harvested
   end
   # Ronseal - any non-nil building will stop this vertex being empty
   def build(building)
     @building = building
   end
   def is_empty?
     !!!@building
   end
   def building
     @building
   end
   # Hexes are added *after* instanciation with the real class and the same is true here
   # We just keep a list of added hexes
   def add_hex(hex)
     @hexes.push(hex)
   end
   # Test method
   def has_hex(hex)
     @hexes.include?(hex)
   end
   # Edges are added *after* instanciation with the real class and the same is true here
   # We just keep a list of the edges we add
   def add_edge(edge)
     @edges.push(edge)
   end
   # Convenience test method
   def has_edge(edge)
     @edges.include?(edge)
   end
   
   # Returns true if another_vertex shares an edge with this one
   def is_neighbour_of(another_vertex)
     @edges.each do |edge| 
       if edge.head == another_vertex || edge.tail == another_vertex
         return true
       end
     end
     return false
   end
   
   # Returns the edge connecting this vertex to another
   # Very similar to concrete implementation
   def get_connection_to(another_vertex)
     @edges.each do |edge|
       if edge.head == another_vertex || edge.tail == another_vertex
         return edge
       end
     end
   end
   
   def edges
     @edges
   end
   
   # adds the provided player to the networks of this fake
   def network(player)
     @networks[player] = true
   end
   
   def in_network_of(player)
     @networks[player]
   end
   
   def buildable=(some_bool)
     @buildable=some_bool
   end
   
   def is_buildable_on?
     @buildable
   end
   
 end
