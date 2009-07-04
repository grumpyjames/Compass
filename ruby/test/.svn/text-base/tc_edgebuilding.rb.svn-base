require 'test/unit'
require '../test/fakevertex.rb'
require '../test/fake_edge.rb'
require '../impl/edge_building.rb'

class FakePlayer
end

class TC_edge_building < Test::Unit::TestCase
  
  def test_edge_building_builds
    a_fake_edge = FakeEdge.new(FakeVertex.new, FakeVertex.new)
    a_fake_player = FakePlayer.new
    a_test_edge_building = EdgeBuilding.new(a_fake_edge, a_fake_player)
    assert(a_fake_edge.building == a_test_edge_building, 'Building an edge buildable should tell the edge in question what the building is')
  end

  def test_edge_ownership
    a_fake_edge = FakeEdge.new(FakeVertex.new, FakeVertex.new)
    a_fake_player = FakePlayer.new
    a_test_edge_building = EdgeBuilding.new(a_fake_edge, a_fake_player)
    assert(a_test_edge_building.owner == a_fake_player, 'Building should be owned by our fake player')
  end

  def test_construct_with_nils_throws
    a_fake_edge = FakeEdge.new(FakeVertex.new, FakeVertex.new)
    a_fake_player = FakePlayer.new
    begin
      test_edge_building = EdgeBuilding.new(nil, a_fake_player)
      assert(false, 'Should have thrown')
    rescue ArgumentError
      assert(true)
    end

    begin
      test_edge_building = EdgeBuilding.new(a_fake_edge, nil)
      assert(false, 'Should have thrown')
    rescue ArgumentError
      assert(true)
    end
  end
  

end
