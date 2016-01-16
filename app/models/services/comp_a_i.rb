class CompAI

  BOARD = [ ActiveRecord::Point.new(1.0,1.0),
            ActiveRecord::Point.new(1.0,2.0),
            ActiveRecord::Point.new(1.0,3.0),
            ActiveRecord::Point.new(1.0,4.0),
            ActiveRecord::Point.new(1.0,5.0),
            ActiveRecord::Point.new(1.0,6.0),
            ActiveRecord::Point.new(1.0,7.0),
            ActiveRecord::Point.new(1.0,8.0),
            ActiveRecord::Point.new(1.0,9.0),
            ActiveRecord::Point.new(1.0,10.0),
            ActiveRecord::Point.new(2.0,1.0),
            ActiveRecord::Point.new(2.0,2.0),
            ActiveRecord::Point.new(2.0,3.0),
            ActiveRecord::Point.new(2.0,4.0),
            ActiveRecord::Point.new(2.0,5.0),
            ActiveRecord::Point.new(2.0,6.0),
            ActiveRecord::Point.new(2.0,7.0),
            ActiveRecord::Point.new(2.0,8.0),
            ActiveRecord::Point.new(2.0,9.0),
            ActiveRecord::Point.new(2.0,10.0),
            ActiveRecord::Point.new(3.0,1.0),
            ActiveRecord::Point.new(3.0,2.0),
            ActiveRecord::Point.new(3.0,3.0),
            ActiveRecord::Point.new(3.0,4.0),
            ActiveRecord::Point.new(3.0,5.0),
            ActiveRecord::Point.new(3.0,6.0),
            ActiveRecord::Point.new(3.0,7.0),
            ActiveRecord::Point.new(3.0,8.0),
            ActiveRecord::Point.new(3.0,9.0),
            ActiveRecord::Point.new(3.0,10.0),
            ActiveRecord::Point.new(4.0,1.0),
            ActiveRecord::Point.new(4.0,2.0),
            ActiveRecord::Point.new(4.0,3.0),
            ActiveRecord::Point.new(4.0,4.0),
            ActiveRecord::Point.new(4.0,5.0),
            ActiveRecord::Point.new(4.0,6.0),
            ActiveRecord::Point.new(4.0,7.0),
            ActiveRecord::Point.new(4.0,8.0),
            ActiveRecord::Point.new(4.0,9.0),
            ActiveRecord::Point.new(4.0,10.0),
            ActiveRecord::Point.new(5.0,1.0),
            ActiveRecord::Point.new(5.0,2.0),
            ActiveRecord::Point.new(5.0,3.0),
            ActiveRecord::Point.new(5.0,4.0),
            ActiveRecord::Point.new(5.0,5.0),
            ActiveRecord::Point.new(5.0,6.0),
            ActiveRecord::Point.new(5.0,7.0),
            ActiveRecord::Point.new(5.0,8.0),
            ActiveRecord::Point.new(5.0,9.0),
            ActiveRecord::Point.new(5.0,10.0),
            ActiveRecord::Point.new(6.0,1.0),
            ActiveRecord::Point.new(6.0,2.0),
            ActiveRecord::Point.new(6.0,3.0),
            ActiveRecord::Point.new(6.0,4.0),
            ActiveRecord::Point.new(6.0,5.0),
            ActiveRecord::Point.new(6.0,6.0),
            ActiveRecord::Point.new(6.0,7.0),
            ActiveRecord::Point.new(6.0,8.0),
            ActiveRecord::Point.new(6.0,9.0),
            ActiveRecord::Point.new(6.0,10.0),
            ActiveRecord::Point.new(7.0,1.0),
            ActiveRecord::Point.new(7.0,2.0),
            ActiveRecord::Point.new(7.0,3.0),
            ActiveRecord::Point.new(7.0,4.0),
            ActiveRecord::Point.new(7.0,5.0),
            ActiveRecord::Point.new(7.0,6.0),
            ActiveRecord::Point.new(7.0,7.0),
            ActiveRecord::Point.new(7.0,8.0),
            ActiveRecord::Point.new(7.0,9.0),
            ActiveRecord::Point.new(7.0,10.0),
            ActiveRecord::Point.new(8.0,1.0),
            ActiveRecord::Point.new(8.0,2.0),
            ActiveRecord::Point.new(8.0,3.0),
            ActiveRecord::Point.new(8.0,4.0),
            ActiveRecord::Point.new(8.0,5.0),
            ActiveRecord::Point.new(8.0,6.0),
            ActiveRecord::Point.new(8.0,7.0),
            ActiveRecord::Point.new(8.0,8.0),
            ActiveRecord::Point.new(8.0,9.0),
            ActiveRecord::Point.new(8.0,10.0),
            ActiveRecord::Point.new(9.0,1.0),
            ActiveRecord::Point.new(9.0,2.0),
            ActiveRecord::Point.new(9.0,3.0),
            ActiveRecord::Point.new(9.0,4.0),
            ActiveRecord::Point.new(9.0,5.0),
            ActiveRecord::Point.new(9.0,6.0),
            ActiveRecord::Point.new(9.0,7.0),
            ActiveRecord::Point.new(9.0,8.0),
            ActiveRecord::Point.new(9.0,9.0),
            ActiveRecord::Point.new(9.0,10.0),
            ActiveRecord::Point.new(10.0,1.0),
            ActiveRecord::Point.new(10.0,2.0),
            ActiveRecord::Point.new(10.0,3.0),
            ActiveRecord::Point.new(10.0,4.0),
            ActiveRecord::Point.new(10.0,5.0),
            ActiveRecord::Point.new(10.0,6.0),
            ActiveRecord::Point.new(10.0,7.0),
            ActiveRecord::Point.new(10.0,8.0),
            ActiveRecord::Point.new(10.0,9.0),
            ActiveRecord::Point.new(10.0,10.0)]

  def initialize(board)
    @board = board
    @available_positions = BOARD - @board.moves.map(&:position)
  end

  def new_move
    @available_positions.sample
  end

  def analyze
    # considers last move with @board.moves.last to determine next move
  end

end