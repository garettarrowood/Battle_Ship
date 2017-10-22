class MoveLogger
  def initialize(coord, board)
    @coord = coord
    @board = board
  end

  def log!
    if @coord.class == String
      @board.moves.create(position: string_to_point(@coord))
    else
      @board.moves.create(position: @coord)
    end
  end

  private

  def string_to_point(coord)
    x = coord.split('-')[1].to_i
    y = coord.split('-')[0].to_i
    ActiveRecord::Point.new(x, y)
  end
end
