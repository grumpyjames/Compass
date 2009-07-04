require 'test/unit'
require '../impl/board_row.rb'

class TC_boardrow < Test::Unit::TestCase
  def test_constructor_instantiates_and_orders_correct_hexes
    test_string = "+:Blank,Blank,Sea,Lumber,Wool,Grain,Wool,Ore,Sea"
    boardrow_to_test = BoardRow.new(test_string)
    assert(boardrow_to_test[0].resource == Resource::BLANK, 'first hex should be blank')
    assert(boardrow_to_test[1].resource == Resource::BLANK, 'second hex should be blank')
    assert(boardrow_to_test[2].resource == Resource::SEA, 'third hex should be sea')
    assert(boardrow_to_test[3].resource == Resource::LUMBER, 'fourth hex should be lumber')
    assert(boardrow_to_test[4].resource == Resource::WOOL, 'fifth hex should be wool')
    assert(boardrow_to_test[5].resource == Resource::GRAIN, 'sixth hex should be grain')
    assert(boardrow_to_test[6].resource == Resource::WOOL, 'seventh hex should be wool')
    assert(boardrow_to_test[7].resource == Resource::ORE, 'eighth hex should be ore')
    assert(boardrow_to_test[8].resource == Resource::SEA, 'ninth hex should be sea')
  end

end
