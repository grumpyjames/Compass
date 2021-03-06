require 'test/unit'
require '../test/fakevertex.rb'
require '../test/fake_hex.rb'
require '../test/fake_player.rb'
require '../test/fake_board.rb'
require '../test/fake_game.rb'
require '../impl/building.rb'
require '../impl/resource.rb'
require '../impl/building_type.rb'
require '../impl/build_action.rb'

#this class necessarily tests both the action
#and parts of the building class 
class TC_BuildAction < Test::Unit::TestCase
  def build_options(noun, count)
    options = []
    1.upto(count) do |index|
      options.push([index.to_s,noun + " " + index.to_s])
    end
    options
  end
  
  def test_settlement_build_action
    fake_player = FakePlayer.new
    check_action_prompts_costs_and_vertex_setup(BuildingType::SETTLEMENT, fake_player)
    assert(fake_player.resources[Resource::WOOL]=-1)
    assert(fake_player.resources[Resource::GRAIN]=-1)
    assert(fake_player.resources[Resource::LUMBER]=-1)
    assert(fake_player.resources[Resource::BRICK]=-1)
    assert(fake_player.resources[Resource::SETTLEMENT]=-1)
  end

  def test_city_build_action
    fake_player = FakePlayer.new
    check_action_prompts_costs_and_vertex_setup(BuildingType::SETTLEMENT, fake_player)
    assert(fake_player.resources[Resource::GRAIN]=-2)
    assert(fake_player.resources[Resource::ORE]=-3)
    assert(fake_player.resources[Resource::SETTLEMENT]=1)
    assert(fake_player.resources[Resource::CITY]=-1)
  end

  def check_action_prompts_costs_and_vertex_setup(building_type, fake_player)
    action_to_test = BuildAction.new(building_type)
    fake_player.add_responses(["1","2","4"])
    fake_board = FakeBoard.new
    fake_board.set_dimensions(3,3)
    fake_game = FakeGame.new([],fake_board)
    fake_vertex = FakeVertex.new
    fake_player.allow_build_on(fake_vertex)
    cannot_build_on_this_vertex = FakeVertex.new
    fake_hex = FakeHex.new(Resource::WOOL, 5, [cannot_build_on_this_vertex,cannot_build_on_this_vertex,cannot_build_on_this_vertex,
                                               fake_vertex,cannot_build_on_this_vertex,cannot_build_on_this_vertex])
    fake_board.hexes = [[nil,fake_hex,nil],[],[]]
    action_to_test.execute(fake_player, fake_game)
    assert(fake_player.options[0]==build_options("Row",3))
    check_useful_options(fake_player.options[1],build_options("Hex",3),"")
    check_useful_options(fake_player.options[2],[["4","Vertex 4"]], "Should only be prompted to build on valid vertices")
    assert(fake_vertex.building.type==building_type)
    assert(fake_vertex.building.owner==fake_player)
  end

  #third piece of an option is untested - write what you want!
  def check_useful_options(result, expected, error_message)
    i =0
    expected.each do |option|
      assert(option[0]==result[i][0], error_message)
      assert(option[1]==result[i][1], error_message)
      i+=1
    end
  end
end
