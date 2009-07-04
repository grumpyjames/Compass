require '../impl/costs.rb'
require '../impl/building.rb'
require '../impl/building_type.rb'

class BuildSettlementAction
  def execute(player, board)
    row_response = player.prompt("Which row do you want to build upon?", build_options("Row",board.rows)).to_i - 1
    hex_response = player.prompt("Which hex do you want to build upon?", build_options("Hex",board.cols)).to_i - 1
    hex = board.hex_at(row_response, hex_response)
    vertex_response = player.prompt("Which vertex do you want to build upon?", build_vertex_options(player,hex)).to_i - 1
    Costs::COSTS[BuildingType::SETTLEMENT].each do |resource,quantity|
      player.receive(resource, quantity * -1)
    end
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

  def build_vertex_options(player, hex)
    options = []
    0.upto(5) do |index|
      if player.can_build_on_vertex(hex[index])
        presenting_index = (index+1).to_s
        options.push([presenting_index,"Vertex " + presenting_index])
      end
    end
    options
  end
  
end
