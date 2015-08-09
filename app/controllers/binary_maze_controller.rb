class BinaryMazeController < ApplicationController
  
  def index
    size = [params[:size].to_i, 3].max
    @grid = Grid.new(size, size)
    Sidewinder.on(@grid)
  end
  
end