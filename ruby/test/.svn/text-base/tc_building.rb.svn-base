require 'test/unit'
require '../impl/building.rb'
require 'fakevertex.rb'
require '../test/fake_player.rb'
require '../impl/resource.rb'
require '../impl/building_type.rb'

class TC_building < Test::Unit::TestCase

  def test_build_on_vertex
    a_fake_vertex = FakeVertex.new
    a_building = Building.new(BuildingType::SETTLEMENT, FakePlayer.new, a_fake_vertex)
    assert(!a_fake_vertex.is_empty?, 'Vertex should not be empty')
    assert(a_fake_vertex.building==a_building, 'Vertex\'s building should be our test building')
  end

  def test_ownership
    a_fake_player = FakePlayer.new
    a_building = Building.new(BuildingType::SETTLEMENT, a_fake_player, FakeVertex.new)
    assert(a_building.owner == a_fake_player)
  end

  def test_construction_throws_with_nils
    begin
      a_building = Building.new(nil, FakePlayer.new, FakeVertex.new)
      assert(false, 'should throw')
    rescue RuntimeError
      assert(true)
    end
    begin
      a_building = Building.new(BuildingType::SETTLEMENT, nil, FakeVertex.new)
      assert(false, 'should throw')
    rescue RuntimeError
      assert(true)
    end
    begin
      a_building = Building.new(BuildingType::CITY, FakePlayer.new, nil)
      assert(false, 'should throw')
    rescue RuntimeError
      assert(true)
    end
  end

  def test_resource_passing
    a_fake_player = FakePlayer.new
    a_building = Building.new(BuildingType::CITY, a_fake_player, FakeVertex.new)
    a_building.accept(Resource::WOOL)
    expected_resources = Hash.new(0)
    expected_resources[Resource::WOOL] = 2
    assert(expected_resources == a_fake_player.resources, 'Unexpected resources found')
  end

end
