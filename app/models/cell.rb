class Cell
  attr_reader :row, :column
  attr_accessor :north, :south, :east, :west
  
  def initialize(row, column)
    @row, @column = row, column
    @links = {}
  end
  
  def link(cell, do_sym_link=true)
    @links[cell] = true
    cell.link(self, false) if do_sym_link
  end
  
  def unlink(cell, do_sym_link=true)
    @links.delete(cell)
    cell.unlink(self, false) if do_sym_link
  end
  
  def linked?(cell)
    @links.key?(cell)
  end
  
  def links
    @links.keys
  end
  
  def cell_type
    type = 0
    type += 1 unless linked?(south)
    type += 2 unless linked?(east)
    type
  end
  
  def neighbors
    [north, south, east, west].compact
  end
  
  def to_s
    "(#{row},#{column})"
  end
end