require 'test/unit'
require '../impl/dice.rb'

class TC_Dice < Test::Unit::TestCase
	
	def test_result_always_in_range_from_2_to_12 #in 50 rolls, anyway.
		test_dice = Dice.new
		valid = []
		2.upto(12) do |index| valid.push(index) end
		1.upto(50) do |i|
			assert valid.include?(test_dice.roll)
		end
	end
	
end