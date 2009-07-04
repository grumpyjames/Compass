require 'test/unit'
require '../test/fake_hex.rb'
require '../test/fake_edge.rb'
require '../test/fake_player.rb'
require '../impl/resource.rb'
require '../impl/vertex.rb'

class FakeBuilding
  @resource_store
  def initialize()
    @resource_store= Hash.new(0)
  end

  def receive( resource )
    @resource_store[resource] += 1
  end

  def resources
    return @resource_store
  end
end

class FakeModifier

end

class FakeEdgeBuilding
	def initialize(edge,owner)
		edge.build(self)
		@owner = owner
	end
	
	def owner
		@owner
	end
end

class TC_Vertex < Test::Unit::TestCase
  
  def test_empty
    vertex_to_test = Vertex.new()
    assert(vertex_to_test.is_empty?, 'Vertex should have been empty but was not')
  end

  def test_not_empty
    vertex_to_test = Vertex.new.build(FakeBuilding.new)
    assert(!vertex_to_test.is_empty?, 'Vertex was not empty yet claimed it was')
  end

  def test_distribute
    a_building = FakeBuilding.new
    vertex_to_test = Vertex.new().build(a_building)
    vertex_to_test.distribute(Resource::WOOL)
    expected_resources = Hash.new(0)
    expected_resources[Resource::WOOL] = 1
    assert(expected_resources == a_building.resources(), 'Unexpected resources')
  end

  def test_is_neighbour
    vertex_to_test = Vertex.new()
    neighbour_vertex = Vertex.new()
    an_edge = FakeEdge.new(vertex_to_test, neighbour_vertex)
    assert(vertex_to_test.is_neighbour_of(neighbour_vertex), 'Neighbour was not found')
  end

  def test_is_not_neighbour
    vertex_to_test = Vertex.new()
    neighbour_vertex = Vertex.new()
    assert(!vertex_to_test.is_neighbour_of(neighbour_vertex), 'Neighbour was not found')
  end

  def test_is_neighbour_with_multiple_vertices
    vertex_to_test = Vertex.new()
    neighbour_vertices = []
    0.upto(3) do |i| neighbour_vertices[i] = Vertex.new() end
    first_edge =  FakeEdge.new(vertex_to_test, neighbour_vertices[0])
    second_edge = FakeEdge.new(vertex_to_test, neighbour_vertices[1])
    third_edge = FakeEdge.new(neighbour_vertices[1], neighbour_vertices[2])
    fourth_edge = FakeEdge.new(neighbour_vertices[3], vertex_to_test)
    neighbours = [0,1,3]
    neighbours.each do |i| 
      assert(vertex_to_test.is_neighbour_of(neighbour_vertices[i]), 'Neighbour not found')
    end
    assert(!vertex_to_test.is_neighbour_of(neighbour_vertices[2]), 'Neighbour not found')
  end

  def test_can_be_built_on
    vertex_to_test = Vertex.new()
    assert(!vertex_to_test.is_buildable_on?, 'Unconnected vertex should not be buildable on as it is not attached to an interesting hex')
    fake_hex = FakeHex.new(Resource::WOOL, 3, [])
    vertex_to_test.add_hex(fake_hex)
    assert(vertex_to_test.is_buildable_on?, 'Unconnected vertex should be buildable on as it is attached to an interesting hex')
    another_vertex = Vertex.new()
    an_edge = FakeEdge.new(vertex_to_test, another_vertex)
    assert(vertex_to_test.is_buildable_on?, 'Vertex connected only to empty vertex should be buildable on')
  end
  
  def test_in_network_of
    vertex_to_test = Vertex.new()
    fake_player = FakePlayer.new
    assert(!vertex_to_test.in_network_of(fake_player), 'Unconnected vertex should not be in the network of our player')
    another_vertex = Vertex.new()
    an_edge = FakeEdge.new(vertex_to_test, another_vertex)
    assert(!vertex_to_test.in_network_of(fake_player), 'Unconnected vertex should not be in the network of our player')
    a_fake_eb = FakeEdgeBuilding.new(an_edge, fake_player)
    assert(vertex_to_test.in_network_of(fake_player), 'Vertex connected to edge building belonging to player be in the network of player')
  end
  
  def test_has_interesting_hexes
    vertex_to_test = Vertex.new
    assert(!vertex_to_test.interesting?, 'this is an uninteresting vertex')
    vertex_to_test.add_hex(FakeHex.new(Resource::SEA, 2, []))
    vertex_to_test.add_hex(FakeHex.new(Resource::BLANK, 2, []))
    assert(!vertex_to_test.interesting?, 'this is still an uninteresting vertex')                          
    vertex_to_test.add_hex(FakeHex.new(Resource::WOOL, 2, []))
    assert(vertex_to_test.interesting?, 'this is now an interesting vertex')                          
  end

  def test_cannot_be_built_on
    vertex_to_test = Vertex.new
    empty_vertex = Vertex.new
    a_fake_hex = FakeHex.new(Resource::BLANK, 3, [])
    another_fake_hex = FakeHex.new(Resource::SEA, 3, [])
    vertex_to_test.add_hex(a_fake_hex)
    vertex_to_test.add_hex(a_fake_hex)
    assert(!vertex_to_test.is_buildable_on?, 'Vertex with no interesting hexes is not buildable on')
    a_built_on_vertex = Vertex.new.build(FakeBuilding.new)
    FakeEdge.new(vertex_to_test, empty_vertex)
    FakeEdge.new(vertex_to_test, a_built_on_vertex)
    assert(!vertex_to_test.is_buildable_on?, 'Vertex connected to built on vertex should not be buildable on')
  end

  def test_has_no_modifiers
    vertex_to_test = Vertex.new
    assert(!vertex_to_test.has_modifiers?, 'This vertex should have no modifiers')
  end

  def test_has_modifiers
    vertex_to_test = Vertex.new([FakeModifier.new])
    assert(vertex_to_test.has_modifiers?, 'This vertex should have modifiers')
  end
  
  def test_get_connection_to
    vertex_to_test = Vertex.new
    another_vertex = Vertex.new
    a_third_vertex = Vertex.new
    an_edge = FakeEdge.new(vertex_to_test, another_vertex)
    another_edge = FakeEdge.new(vertex_to_test, a_third_vertex)
    assert(vertex_to_test.get_connection_to(another_vertex)==an_edge)
    assert(vertex_to_test.get_connection_to(a_third_vertex)==another_edge)
  end
  
end
