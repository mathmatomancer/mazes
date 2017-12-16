class MazeController < ApplicationController
  
  def index
    size = [params[:size].to_i, 3].max
    size = [size, 50].min # limit size for now to small canvas size
    @grid = Grid.new(size, size)
    maze_class = params[:maze_type]
    if ['BinaryTree','Sidewinder'].include? maze_class
      maze_class.constantize.on(@grid)
    else
      Sidewinder.on(@grid)
    end
  end
  
end