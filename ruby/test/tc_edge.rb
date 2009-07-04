require 'test/unit'
require 'fakevertex.rb'
require '../impl/edge.rb'

class FakeRoad
  def edge=(edge)
    @edge = edge
  end

  def edge
    @edge
  end
end

class TC_Edge < Test::Unit::TestCase
    
  def test_has_vertex
    fake_vertex_one = FakeVertex.new
    fake_vertex_two = FakeVertex.new
    fake_vertex_three = FakeVertex.new
    edge_to_test = Edge.new(fake_vertex_one, fake_vertex_two)
    assert(edge_to_test.has_vertex?(fake_vertex_one), 'Edge should have this vertex')
    assert(edge_to_test.has_vertex?(fake_vertex_two), 'Edge should have this vertex, too')
    assert(!edge_to_test.has_vertex?(fake_vertex_three), 'Edge should not have this vertex')
  end
  
  def test_head_and_tail
    fake_vertex_one = FakeVertex.new
    fake_vertex_two = FakeVertex.new
    edge_to_test = Edge.new(fake_vertex_one, fake_vertex_two)
    assert(edge_to_test.head == fake_vertex_one, 'wrong head found')
    assert(edge_to_test.tail == fake_vertex_two, 'wrong tail found')
  end

  def test_is_empty
    fake_vertex_one = FakeVertex.new
    fake_vertex_two = FakeVertex.new
    edge_to_test = Edge.new(fake_vertex_one, fake_vertex_two)
    assert(edge_to_test.is_empty?, 'Newly instantiated edge should be empty')
    edge_to_test.build(FakeRoad.new)
    assert(!edge_to_test.is_empty?, 'Road should have stopped edge being empty')
  end
  
  def test_vertex_callback
	fake_vertex_one = FakeVertex.new
    fake_vertex_two = FakeVertex.new
    edge_to_test = Edge.new(fake_vertex_one, fake_vertex_two)
	assert(fake_vertex_one.has_edge(edge_to_test))
	assert(fake_vertex_two.has_edge(edge_to_test))
  end
  
end
