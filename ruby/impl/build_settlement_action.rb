require '../impl/costs.rb'
require '../impl/building.rb'
require '../impl/building_type.rb'

class BuildSettlementAction
  def execute(player, board)
    row_response = player.prompt("Which row do you want to build upon?", build_options("Row",board.rows)).to_i - 1
    hex_response = player.prompt("Which hex do you want to build upon?", build_options("Hex",board.cols)).to_i - 1
    vertex_response = player.prompt("Which vertex do you want to build upon?", build_options("Vertex",6)).to_i - 1
    Costs::COSTS[BuildingType::SETTLEMENT].each do |resource,quantity|
      player.receive(resource, quantity * -1)
    end
    hex = board.hex_at(row_response, hex_response)
    vertex = hex[vertex_response]
    settlement = Building.new(BuildingType::SETTLEMENT, player, vertex)
  end

  private
  def build_options(noun, count)
    options = []
    1.upto(count) do |index|
      options.push([index.to_s, noun + " " + index.to_s])
    end
    options
  end
  
end
