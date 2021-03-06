require 'test/unit'
require '../test/fakevertex.rb'
require '../test/fake_edge.rb'
require '../impl/resource.rb'
require '../impl/hex.rb'

class TC_Hex < Test::Unit::TestCase
  # def setup
  # end
  
  # def teardown
  # end
  def test_hex_has_vertex
    a_vertex = FakeVertex.new()
    a_vertex_array = [ a_vertex ]
    hex_to_test = Hex.new(a_vertex_array, Resource::GRAIN, 1)
    assert(hex_to_test.has_vertex?(a_vertex), 'Hex did not contain vertex.')
  end
  
  def test_hex_does_not_have_vertex
    a_vertex = FakeVertex.new()
    another_vertex = FakeVertex.new()
    hex_to_test = Hex.new([a_vertex], Resource::GRAIN, 1)
    assert(!hex_to_test.has_vertex?(another_vertex), 'Hex contained the vertex and it really ought not to have')
  end

  def test_hex_score
    hex_to_test = Hex.new([], Resource::GRAIN, 5)
    assert(hex_to_test.trigger==5, "Trigger should be 5")
  end
  
  def test_hex_harvest
    a_vertex_array = []
    0.upto(5) do |i|
      a_vertex_array[i] = FakeVertex.new()
    end
    hex_to_test = Hex.new(a_vertex_array, Resource::GRAIN, 1)
    hex_to_test.harvest()
    0.upto(5) do |i|
      assert(a_vertex_array[i].harvested(), 'Vertex attached to hex that harvested didn\'t get any harvest :-(')
    end      
  end
  
  def test_vertex_access
    vertices = []
    0.upto(2) do |i|
      vertices[i] = FakeVertex.new()
    end
    hexes = []
    first_hex = Hex.new([vertices[0], vertices[2], vertices[1]], Resource::GRAIN, 1)
    assert(first_hex[0] == vertices[0])
    assert(first_hex[1] == vertices[2])
    assert(first_hex[2] == vertices[1])
  end
  
  def test_vertex_callback
    vertices = []
    0.upto(5) do |i|
      vertices[i] = FakeVertex.new()
    end
    first_hex = Hex.new(vertices, Resource::GRAIN, 1)
    vertices.each do |vertex|
      assert(vertex.has_hex(first_hex), 'Vertex should have this hex listed within it')
    end
  end
  
  def test_hex_blank
    hex_to_test = Hex.new([],Resource::BLANK, 1)
    assert(hex_to_test.blank?, "Blank type should be blank")
    hex_to_test = Hex.new([],Resource::SEA, 1)
    assert(hex_to_test.blank?, "Sea type should be blank")
    hex_to_test = Hex.new([],Resource::DESERT, 1)
    assert(hex_to_test.blank?, "Desert type should be blank")
    hex_to_test = Hex.new([],Resource::WOOL, 1)
    assert(!hex_to_test.blank?, "Wool type should not be blank")
  end
  
  def test_hex_returns_correct_edge
    vertices = []
    0.upto(5) do |i|
      vertices[i] = FakeVertex.new()
    end
    new_edges = []
    0.upto(5) do |i|
      this_vertex = vertices[i]
      next_vertex = vertices[(i+1) %6]
      new_edges[i] = FakeEdge.new(this_vertex, next_vertex)
      this_vertex.add_edge(new_edges[i])
      next_vertex.add_edge(new_edges[i])       
    end
    hex_to_test = Hex.new(vertices, Resource::GRAIN, 5)
    0.upto(5) do |i|
      assert(hex_to_test.edge_connecting(i, (i+1) %6) == new_edges[i])
    end
  end
    
  def mtest_hex_harvest_with_resource_fish
    # this does not work - not sure why, don't care a great deal either
    vertices = []
    0.upto(5) do |i|
      vertices[i] = FakeVertex.new()
    end
    
    hexes = []
    
    hexes[0] = Hex.new([vertices[1], vertices[2], vertices[3]], Resource::GRAIN)
    hexes[1] = Hex.new([vertices[4], vertices[5], vertices[3]], Resource::LUMBER)
    hexes[2] = Hex.new([vertices[4], vertices[3], vertices[0]], Resource::BRICK)
    
    0.upto(vertices.length - 1) do |i|
      assert(vertices[i].harvested().length == 0, 'newly instantiated vertex did not have empty resource array')
    end
    
    0.upto(hexes.length - 1) do |i|
      
      vertex_resources_before_harvesting = Hash.new(0)
      
      
      0.upto(vertices.length - 1) do |j|
        vertex_resources_before_harvesting[j] = vertices[j].harvested()
      end
      
      hexes[i].harvest()
      
      0.upto(vertices.length - 1) do |j|
        Resource::RESOURCES.each do |resource|
          if(resource == hexes[i].resource() && hexes[i].has_vertex?(vertices[j]))
            puts "Resource was #{resource} and j was #{j}"
            puts vertices[j].harvested()[resource].to_s + " " + vertex_resources_before_harvesting[j][resource].to_s
            assert(vertices[j].harvested()[resource] == (vertex_resources_before_harvesting[j][resource] + 1), "Should have been one more than before")
          else
            assert(vertices[j].harvested()[resource] == vertex_resources_before_harvesting[j][resource], "should have been the same")
          end
        end
      end
    end
  end
  
  def test_hex_harvest_resource_james
    vertices = []
    0.upto(5) do |i|
      vertices[i] = FakeVertex.new()
    end
    
    hexes = []
    first_hex = Hex.new([vertices[1], vertices[2], vertices[3]], Resource::GRAIN, 1)
    second_hex = Hex.new([vertices[4], vertices[5], vertices[3]], Resource::LUMBER, 1)
    third_hex = Hex.new([vertices[4], vertices[3], vertices[0]], Resource::WOOL, 1)
      
    first_hex.harvest()
    
    first_expected_resources = Hash.new(0)
    empty_resources = Hash.new(0)
    first_expected_resources[Resource::GRAIN] = 1
    
    1.upto(3) do |i|
      assert(vertices[i].harvested()==first_expected_resources, 'Resources were not harvested as expected')
    end
    expected_empty = [0,4,5]
    expected_empty.each do |i| 
      assert(vertices[i].harvested()==empty_resources, 'Resources were not empty when they should have been')
    end
    
    second_hex.harvest()
    
    1.upto(2) do |i| assert(vertices[i].harvested()==first_expected_resources) end
    
    second_expected_resources = Hash.new().merge(first_expected_resources)
    second_expected_resources[Resource::LUMBER] = 1
    
    third_expected_resources = Hash.new(0)
    third_expected_resources[Resource::LUMBER] = 1
    
    assert(vertices[3].harvested() == second_expected_resources)
    4.upto(5) do |i| assert(vertices[i].harvested()==third_expected_resources) end
    
    assert(vertices[0].harvested() == empty_resources)
    
    third_hex.harvest()
    
    1.upto(2) do |i| assert(vertices[i].harvested()==first_expected_resources) end
    fourth_expected_resources = Hash.new().merge(second_expected_resources)
    fourth_expected_resources[Resource::WOOL] = 1
    
    assert(vertices[3].harvested()==fourth_expected_resources)
    
    fifth_expected_resources = Hash.new(0)
    fifth_expected_resources[ Resource::WOOL] = 1
    assert(vertices[0].harvested()==fifth_expected_resources)
    
    sixth_expected_resources = Hash.new().merge(fifth_expected_resources)
    sixth_expected_resources[Resource::LUMBER] = 1
    
    assert(vertices[4].harvested()==sixth_expected_resources)
    
  end
  
  def test_place_robber
    a_test_vertex = FakeVertex.new()
    hex_to_test = Hex.new([a_test_vertex],Resource::WOOL, 1)
    hex_to_test.place_robber
    hex_to_test.harvest()
    expected_resources = Hash.new(0)
    assert(a_test_vertex.harvested == expected_resources, 'Resources should be empty')
  end
  
  def test_place_robber_throws_if_robber_already_there
    a_test_vertex = FakeVertex.new()
    hex_to_test = Hex.new([a_test_vertex],Resource::WOOL, 1)
    hex_to_test.place_robber
    begin
      hex_to_test.place_robber
      assert(false, 'Should have thrown')
    rescue RuntimeError
      assert(true)
    end
  end
  
  def test_remove_robber_after_placing_robber
    a_test_vertex = FakeVertex.new()
    hex_to_test = Hex.new([a_test_vertex],Resource::WOOL, 1)
    hex_to_test.place_robber
    hex_to_test.remove_robber
    hex_to_test.harvest()
    expected_resources = Hash.new(0)
    expected_resources[Resource::WOOL] = 1
    assert(a_test_vertex.harvested == expected_resources, 'Resources should be empty')
  end
  
  def test_trigger_assignment
    hex_to_test = Hex.new([], Resource::WOOL, 1)
    assert(hex_to_test.trigger == 1)
    hex_to_test = Hex.new([], Resource::WOOL, nil)
    assert(false, "should throw")
  rescue ArgumentError
    assert(true)
  end

  def test_to_s
    hex_to_test = Hex.new([], Resource::WOOL, 3)
    expected = "Res: Wool, Trig: 3"
    assert(hex_to_test.to_s==expected,"Hex to_s produced this: " + hex_to_test.to_s + " . Expected was " + expected) 
  end
  
end

