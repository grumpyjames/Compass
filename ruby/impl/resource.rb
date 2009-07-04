class Resource
  GRAIN=0
  WOOL=1
  ORE=2
  LUMBER=3
  BRICK=4
  BLANK=5
  SEA=6
  DESERT=7  
  CITY=8
  SETTLEMENT=9
  ROAD=10
  SHIP=11
  RESOURCES=[GRAIN, WOOL, ORE, LUMBER, BRICK]
  BLANK_TYPES=[BLANK, SEA, DESERT]
  CONFIG_HASH = {
    :grain => GRAIN,
    :wool => WOOL,
    :ore => ORE,
    :lumber => LUMBER,
    :brick => BRICK,
    :blank => BLANK,
    :sea => SEA,
    :desert => DESERT
  }
  NAMES = CONFIG_HASH.invert
end
  
