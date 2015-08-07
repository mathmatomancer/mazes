class Grid
  attr_reader :rows, :columns
  
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @grid = prepare_grid
    configure_cells
    
    raise "same object in each cell" if @grid[0][0] === @grid[0][1]

  end
  
  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |col|
        Cell.new(row, col)
      end
    end    
  end
  
  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column
      cell.north = self[row - 1, col]
      cell.south = self[row + 1, col]
      cell.west  = self[row, col - 1]
      cell.east  = self[row, col + 1]
    end
  end
  
  def [](row, column)
    return nil unless row < @rows && column < @columns && row >= 0 && column >= 0
    @grid[row][column]
  end
  
  def random_cell
    row = rand(rows)
    col = rand(@grid[row].count)
    self[row, col]
  end
  
  def size
    rows * columns
  end
  
  def each_row
    @grid.each do |row|
      yield row
    end
  end
  
  def each_cell
    each_row do |row|
      row.each do |cell|
        yield cell if cell
      end
    end
  end
  
  def to_s
    output = "+" + "---+"*columns + "\n"
    
    each_row do |row|
      top = "|"
      bottom = "+"
      
      row.each do |cell|
        # cell = Cell.new(-1,-1) unless cell # make sure nils later don't mess up
        body = " #{cell.cell_type} "
        corner = "+"
        east_boundary = cell.linked?(cell.east) ? " " : "|"
        south_boundary = cell.linked?(cell.south) ? "   " : "---"
        
        top << body << east_boundary
        bottom << south_boundary << corner
      end
      
      output << top << "\n"
      output << bottom << "\n"
    end
    
    output
  end
  
  def to_json
    json = {rows: rows, columns: columns, data: []}
    each_row do |row|
      json[:data] << row.map do |cell|
        cell.cell_type
      end
    end
    
    json.to_json
  end
end