require '../impl/resource.rb'
require '../impl/building_type.rb'
require '../impl/edge_building_type.rb'

class Costs
  DEV_CARD = 101
  COSTS = {
    BuildingType::SETTLEMENT => { Resource::BRICK => 1, Resource::LUMBER => 1, Resource::GRAIN => 1, Resource::WOOL => 1 },
    BuildingType::CITY => { Resource::GRAIN => 2, Resource::ORE => 3 },
    DEV_CARD => { Resource::WOOL => 1, Resource::ORE => 1, Resource::GRAIN => 1 },
    EdgeBuildingType::ROAD => {Resource::BRICK => 1, Resource::LUMBER => 1},
    EdgeBuildingType::SHIP => {Resource::WOOL => 1, Resource::LUMBER => 1}
  }   
end

class Buildable
	
	def initialize(costs,name,klass)
		@costs = costs
		@name = name
		@klass = klass
	end
	
	def building
		
	end
	
	#ROAD = self.initialize({ Resource::BRICK => 1, Resource::LUMBER => 1, Resource::GRAIN => 1, Resource::WOOL => 1 }, "Road")
end
