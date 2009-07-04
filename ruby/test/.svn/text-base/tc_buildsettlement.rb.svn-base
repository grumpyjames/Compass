require 'test/unit'
require '../test/fakevertex.rb'
require '../test/fake_hex.rb'
require '../test/fake_player.rb'
require '../test/fake_board.rb'
require '../impl/building.rb'
require '../impl/resource.rb'
require '../impl/building_type.rb'
require '../impl/build_settlement_action.rb'

#this class necessarily tests both the action
#and parts of the building class 
class TC_BuildSettlementAction < Test::Unit::TestCase
  def build_options(noun, count)
    options = []
    1.upto(count) do |index|
      options.push([index.to_s,noun + " " + index.to_s])
    end
    options
  end
  
  def testActionPromptsCorrectly
    action_to_test = BuildSettlementAction.new
    fake_player = FakePlayer.new
    fake_player.add_responses(["1","2","4"])
    fake_board = FakeBoard.new
    fake_board.set_dimensions(3,3)
    fake_vertex = FakeVertex.new
    fake_hex = FakeHex.new(Resource::WOOL, 5, [nil,nil,nil,fake_vertex,nil,nil])
    fake_board.hexes = [[nil,fake_hex,nil],[],[]]
    action_to_test.execute(fake_player, fake_board)
    assert(fake_player.options[0]==build_options("Row",3))
    assert(fake_player.options[1]==build_options("Hex",3))
    assert(fake_player.options[2]==build_options("Vertex",6))
    assert(fake_vertex.building.type==BuildingType::SETTLEMENT)
    assert(fake_vertex.building.owner==fake_player)
    assert(fake_player.resources[Resource::WOOL]=-1)
    assert(fake_player.resources[Resource::GRAIN]=-1)
    assert(fake_player.resources[Resource::LUMBER]=-1)
    assert(fake_player.resources[Resource::BRICK]=-1)
  end
end
