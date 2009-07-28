require 'test/unit'
require '../impl/resource.rb'
require '../impl/player.rb'
require '../impl/costs.rb'
require '../impl/edge_building_type.rb'
require '../impl/building_type.rb'
require '../test/fakevertex.rb'
require '../test/fake_edge.rb'

class SimpleFakeGame
  def next_turn
    @next_called = true
  end
  def next_called
    @next_called
  end
end

class FakeStdIn
  def initialize(things_to_read)
    @things_to_read = things_to_read
    @position = -1
  end
  
  def read
    @position+=1
    @things_to_read[@position]
  end
end

class FakeStdOut
  def initialize
    @output = []
  end
  
  def puts(line)
    @output.push(line)
  end
  
  def output
    @output
  end
end

class FakeAction
  def execute(actor)
    @actor  = actor
  end
  
  def actor
    @actor
  end
end

class TC_player < Test::Unit::TestCase
  
  def test_accepts_resources
    player_to_test = Player.new
    player_to_test.receive(Resource::WOOL, 4)
    player_to_test.receive(Resource::GRAIN, 1)
    player_to_test.receive(Resource::LUMBER, 3)
    expected_resources = Hash.new(0)
    expected_resources[Resource::WOOL] = 4
    expected_resources[Resource::GRAIN] = 1
    expected_resources[Resource::LUMBER] = 3
    assert(player_to_test.resource_count == 8)
    assert(player_to_test.resources == expected_resources, 'Unexpected resource found')
  end

  def check_resource_permutations_for_build (cost_key)
    required_array = Costs::COSTS[cost_key].to_a
    0.upto(required_array.length-1) do
      player_to_test = Player.new
      0.upto(required_array.length-2) do |i|
        player_to_test.receive(required_array[i][0], required_array[i][1])
        if (required_array[i+1][1] > 0)
          assert(!player_to_test.can_buy?(cost_key), 'Cannot develop without resource type ' + required_array.last[0].to_s)
        end
      end
      player_to_test.receive(required_array.last[0], required_array.last[1])
      assert(player_to_test.can_buy?(cost_key), 'Can develop with required resource types')
    end  
  end

  def test_can_buy
    check_resource_permutations_for_build(Costs::DEV_CARD)
    check_resource_permutations_for_build(EdgeBuildingType::ROAD) 
    check_resource_permutations_for_build(BuildingType::SETTLEMENT) 
    check_resource_permutations_for_build(BuildingType::CITY) 
    check_resource_permutations_for_build(EdgeBuildingType::SHIP) 
  end
  
  def test_end_of_turn
    player_to_test = Player.new
    a_fake_game = SimpleFakeGame.new
    player_to_test.add_to_game(a_fake_game)
    player_to_test.end_turn
    assert(a_fake_game.next_called)
  end
  
  def test_prompt
    a_fake_stdout = FakeStdOut.new
    player_to_test = Player.new(FakeStdIn.new(["1"]), a_fake_stdout)
    assert(player_to_test.prompt("What do you want to do?", [["1","Do Something"],["2", "Do Something Else"]]) == "1")
    assert(a_fake_stdout.output[1] == "1: Do Something, 2: Do Something Else", a_fake_stdout.output[1])
  end
  
  def test_prompt_is_persistent
    a_fake_stdout = FakeStdOut.new
    player_to_test = Player.new(FakeStdIn.new(["0","0","1"]), a_fake_stdout)
    assert(player_to_test.prompt("What do you want to do?",[["1","Do Something"],["2", "Do Something Else"]]) == "1")
    assert(a_fake_stdout.output[1] == "1: Do Something, 2: Do Something Else", a_fake_stdout.output[1])
  end
  
  def test_take_action
    player_to_test = Player.new(STDIN, STDOUT)
    fake_action = FakeAction.new
    player_to_test.take(fake_action)
    assert(fake_action.actor, player_to_test)
    assert(player_to_test.actions.first == fake_action)
  end
  
  def test_can_build_on_vertex
    player_to_test = Player.new(STDIN, STDOUT)
    fake_vertex = FakeVertex.new
    fake_vertex.buildable = false
    assert(!player_to_test.can_build_on_vertex(fake_vertex), 'Vertex not in network and not buildable on should not be buildable on')
    fake_vertex.buildable = true
    assert(!player_to_test.can_build_on_vertex(fake_vertex), 'Vertex not in network yet buildable on should not be buildable on')
    fake_vertex.network(player_to_test)
    assert(player_to_test.can_build_on_vertex(fake_vertex), 'Vertex in network and buildable on should be buildable on')
    fake_vertex.buildable = false
    assert(!player_to_test.can_build_on_vertex(fake_vertex), 'Vertex in network yet not buildable on should not be buildable on')
  end
  
end
