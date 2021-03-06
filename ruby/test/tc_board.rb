require 'test/unit'
require '../test/fakevertex.rb'
require '../test/fake_hex.rb'
require '../test/fake_edge.rb'
require '../impl/board.rb'
require '../impl/resource.rb'

class FakeHexBuilder
  def make_hex(vertices, resource, score)
    FakeHex.new(resource, score, vertices)
  end
end

class FakeVertexBuilder
  def make_vertex
    FakeVertex.new
  end
end

class TC_board < Test::Unit::TestCase

  def test_board_links_correct_vertices_across_a_row
    board_string = "blank,Sea,ore,wool,sEa,BLANK:11,2\nblank,Sea,ore,wool,sEa,BLANK:11,2"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    assert(board_to_test.hex_at(0,0).upper_right == board_to_test.hex_at(0,1).upper_left)
    assert(board_to_test.hex_at(0,0).lower_right == board_to_test.hex_at(0,1).lower_left)
    assert(board_to_test.hex_at(0,1).upper_right == board_to_test.hex_at(0,2).upper_left)
    assert(board_to_test.hex_at(0,1).lower_right == board_to_test.hex_at(0,2).lower_left)
    assert(board_to_test.hex_at(0,2).upper_right == board_to_test.hex_at(0,3).upper_left)
    assert(board_to_test.hex_at(0,2).lower_right == board_to_test.hex_at(0,3).lower_left)
    assert(board_to_test.hex_at(1,0).upper_right == board_to_test.hex_at(1,1).upper_left)
    assert(board_to_test.hex_at(1,0).lower_right == board_to_test.hex_at(1,1).lower_left)
    assert(board_to_test.hex_at(1,1).upper_right == board_to_test.hex_at(1,2).upper_left)
    assert(board_to_test.hex_at(1,1).lower_right == board_to_test.hex_at(1,2).lower_left)
    assert(board_to_test.hex_at(1,2).upper_right == board_to_test.hex_at(1,3).upper_left)
    assert(board_to_test.hex_at(1,2).lower_right == board_to_test.hex_at(1,3).lower_left)
  end

  def test_board_links_correct_vertices_across_two_rows
    #we're assuming the top row is always offset by a half tile here
    board_string = "blank,Sea,ore,sEa,BLANK:11\nblank,Sea,ore,sEa,BLANK:11"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    assert(board_to_test.hex_at(0,0).lower_left == board_to_test.hex_at(1,0).top)
    assert(board_to_test.hex_at(0,0).bottom == board_to_test.hex_at(1,0).upper_right)
    assert(board_to_test.hex_at(0,1).lower_left == board_to_test.hex_at(1,1).top)
    assert(board_to_test.hex_at(0,1).bottom == board_to_test.hex_at(1,1).upper_right)
    assert(board_to_test.hex_at(0,1).lower_right == board_to_test.hex_at(0,2).lower_left)
    assert(board_to_test.hex_at(0,1).lower_right == board_to_test.hex_at(1,2).top)
    assert(board_to_test.hex_at(0,2).lower_left == board_to_test.hex_at(1,2).top)
    assert(board_to_test.hex_at(0,2).bottom == board_to_test.hex_at(1,2).upper_right)
    assert(board_to_test.hex_at(0,2).lower_right == board_to_test.hex_at(1,3).top)
    assert(board_to_test.hex_at(0,4).lower_left == board_to_test.hex_at(1,4).top)
    assert(board_to_test.hex_at(0,4).bottom == board_to_test.hex_at(1,4).upper_right)
  end

  def test_board_links_correct_vertices_across_three_rows
    #here we start having to deal with row offsets - still assume top row is half a tile inset
    board_string = "blank,Sea,ore,sEa,BLANK:11\nblank,Sea,ore,sEa,BLANK:11\nblank,Sea,ore,sEa,BLANK:11"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    assert(board_to_test.hex_at(2,0).top == board_to_test.hex_at(1,0).lower_right)
    assert(board_to_test.hex_at(2,0).upper_left == board_to_test.hex_at(1,0).bottom)
    assert(board_to_test.hex_at(2,0).upper_right == board_to_test.hex_at(1,1).bottom)
  end
  
  def test_board_has_correct_hexes_1
    board_string = "blank,Sea,ore,sEa,BLANK:1\nblank,sea,wool,sea,blank:6"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    assert(board_to_test.hex_at(0,0).resource == Resource::BLANK)
    assert(board_to_test.hex_at(0,1).resource == Resource::SEA)
    assert(board_to_test.hex_at(0,2).resource == Resource::ORE)
    assert(board_to_test.hex_at(0,3).resource == Resource::SEA)
    assert(board_to_test.hex_at(0,4).resource == Resource::BLANK)
    assert(board_to_test.hex_at(1,0).resource == Resource::BLANK)
    assert(board_to_test.hex_at(1,1).resource == Resource::SEA)
    assert(board_to_test.hex_at(1,2).resource == Resource::WOOL)
    assert(board_to_test.hex_at(1,3).resource == Resource::SEA)
    assert(board_to_test.hex_at(1,4).resource == Resource::BLANK)
  end
  
  class FakeEdgeBuilder
    def make_edge(head, tail)
      FakeEdge.new(head, tail)
    end
  end
  
  def test_single_hex_vertices_are_connected
    board_string = "blank:"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    hex = board_to_test.hex_at(0,0)
    check_hex_linkage(hex)
  end
  
  def check_hex_linkage(hex)
    assert(hex[0].is_neighbour_of(hex[1]))
    assert(hex[0].is_neighbour_of(hex[2]))
    assert(hex[1].is_neighbour_of(hex[3]))
    assert(hex[4].is_neighbour_of(hex[5]))
    assert(hex[2].is_neighbour_of(hex[4]))
    assert(hex[3].is_neighbour_of(hex[5]))
  end
  
  def test_two_hex_row_shares_correct_edges
    board_string = "blank,blank:"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    the_first_hex = board_to_test.hex_at(0,0)
    the_second_hex = board_to_test.hex_at(0,1)
    check_hex_linkage(the_first_hex)
    check_hex_linkage(the_second_hex)
    middle_edge = the_first_hex[2].get_connection_to(the_first_hex[4])
    assert(the_first_hex[2].is_neighbour_of(the_second_hex[0]))
    assert(the_first_hex[2].is_neighbour_of(the_second_hex[3]))
    assert(the_first_hex[4].is_neighbour_of(the_second_hex[1]))
    assert(the_first_hex[4].is_neighbour_of(the_second_hex[5]))
    assert(the_first_hex[2].edges.size == 3)
    assert(the_first_hex[4].edges.size == 3)
    assert(the_second_hex[1].edges.size == 3)
    assert(the_second_hex[3].edges.size == 3)
    assert(middle_edge == the_second_hex[1].get_connection_to(the_second_hex[3]))
  end
  
  def test_two_row_board_shares_correct_edges
    board_string = "blank,blank:\nblank,blank:"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    first_row_first_hex = board_to_test.hex_at(0,0)
    first_row_second_hex = board_to_test.hex_at(0,1)
    second_row_first_hex = board_to_test.hex_at(1,0)
    second_row_second_hex = board_to_test.hex_at(1,1)
    check_hex_linkage(first_row_first_hex)
    check_hex_linkage(first_row_second_hex)
    check_hex_linkage(second_row_first_hex)
    check_hex_linkage(second_row_second_hex)
    assert(first_row_first_hex[3].is_neighbour_of(second_row_first_hex[1]))
    assert(first_row_first_hex[3].is_neighbour_of(second_row_first_hex[2]))
    assert(first_row_first_hex[5].is_neighbour_of(second_row_first_hex[0]))
    assert(first_row_first_hex[5].is_neighbour_of(second_row_first_hex[4]))
    assert(first_row_first_hex[4] == first_row_second_hex[3])
    assert(first_row_second_hex[3] == second_row_second_hex[0])
    assert(first_row_second_hex[3].is_neighbour_of(second_row_second_hex[1]))
    assert(first_row_second_hex[3].is_neighbour_of(second_row_second_hex[2]))
    assert(first_row_second_hex[5].is_neighbour_of(second_row_second_hex[0]))
    assert(first_row_second_hex[5].is_neighbour_of(second_row_second_hex[4]))
    assert(first_row_first_hex[3].edges.size == 3)
    assert(first_row_first_hex[5].edges.size == 3)
    assert(first_row_second_hex[3].edges.size == 3)
    assert(first_row_second_hex[5].edges.size == 3)
    assert(second_row_first_hex[0].edges.size == 3)
    assert(second_row_first_hex[2].edges.size == 3)
    assert(second_row_second_hex[0].edges.size == 3)
    assert(second_row_second_hex[2].edges.size == 3)
  end
  
  def test_correct_trigger_assignment
    board_string = "blank,sea,desert,ore,wool,lumber,lumber,grain,sea,blank:5,6,7,8,9"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    3.upto(7) do |i|
      assert(board_to_test.hex_at(0, i).trigger == i+2, (i+2).to_s + " should be equal to " + board_to_test.hex_at(0, i).trigger.to_s)
    end
  end
  
  def test_board_harvests_correct_hexes
    board_string = "blank,sea,desert,ore,wool,lumber,lumber,grain,sea,blank:5,6,7,8,9\nblank,sea,desert,ore,wool,lumber,lumber,grain,sea,blank:7,4,2,3,9"
    board_to_test = Board.new(FakeHexBuilder.new, FakeVertexBuilder.new, FakeEdgeBuilder.new, board_string)
    board_to_test.harvest(5)
    board_to_test.harvest(9)
    board_to_test.harvest(8)
    board_to_test.harvest(6)
    board_to_test.harvest(5)
    board_to_test.harvest(10)
    assert(board_to_test.hex_at(0,0).harvest_count == 0)
    assert(board_to_test.hex_at(0,3).harvest_count == 2)
    assert(board_to_test.hex_at(0,4).harvest_count == 1)
    assert(board_to_test.hex_at(0,5).harvest_count == 0)
    assert(board_to_test.hex_at(1,0).harvest_count == 0)
    assert(board_to_test.hex_at(1,3).harvest_count == 0)
    assert(board_to_test.hex_at(1,4).harvest_count == 0)
    assert(board_to_test.hex_at(1,5).harvest_count == 0)
    assert(board_to_test.hex_at(1,7).harvest_count == 1)
  end
  
end
