require '../impl/resource.rb'
require '../impl/building_type.rb'
require '../impl/edge_building_type.rb'

class Costs
  DEV_CARD = 101
  COSTS = {
    BuildingType::SETTLEMENT => { Resource::BRICK => 1, Resource::LUMBER => 1, Resource::GRAIN => 1, Resource::WOOL => 1, Resource::SETTLEMENT => 1},
    #place any negative numbers towards the beginning - the test code that deals with this isn't robust enough to cope otherwise
    BuildingType::CITY => {  Resource::GRAIN => 2, Resource::SETTLEMENT => -1, Resource::ORE => 3, Resource::CITY => 1},
    DEV_CARD => { Resource::WOOL => 1, Resource::ORE => 1, Resource::GRAIN => 1 },
    EdgeBuildingType::ROAD => {Resource::BRICK => 1, Resource::LUMBER => 1, Resource::ROAD => 1},
    EdgeBuildingType::SHIP => {Resource::WOOL => 1, Resource::LUMBER => 1, Resource::SHIP => 1}
  }   
end
