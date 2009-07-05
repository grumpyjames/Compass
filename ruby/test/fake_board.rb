class FakeBoard

  def initialize
    @harvested = []
  end

  def set_dimensions(rows, cols)
    @rows=rows
    @cols=cols
  end
  
  def hexes=(hexes)
    @hexes=hexes
  end
  
  def hex_at(row, col)
    selected_row = @hexes[row]
    selected_row[col]
  end

  def rows
    @rows
  end

  def cols
    @cols
  end
  
  def harvest(score)
    @harvested.push(score)
  end

  def harvested
    @harvested
  end
end
