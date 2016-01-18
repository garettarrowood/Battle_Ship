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

  def new_move # returns a position
    case analyze
    when "random"
      @available_positions.sample
    when "educated guess"
      return left(@last_hit.position) if @available_positions.include?(left(@last_hit.position))
      return down(@last_hit.position) if @available_positions.include?(down(@last_hit.position))
      return right(@last_hit.position) if @available_positions.include?(right(@last_hit.position))
      return up(@last_hit.position) if @available_positions.include?(up(@last_hit.position))
      second_last = @board.damaging_moves.sort_by { |move| move.id }[-2].position
      return left(second_last) if @available_positions.include?(left(second_last))
      return down(second_last) if @available_positions.include?(down(second_last))
      return right(second_last) if @available_positions.include?(right(second_last))
      return up(second_last) if @available_positions.include?(up(second_last))
      return @available_positions.sample
    end
  end

  def analyze
    return "random" if @board.damaging_moves.length == 0
    @last_hit = @board.damaging_moves.sort_by { |move| move.id }[-1]
    return "random" if @board.sinking_move?(@last_hit)
    "educated guess"
  end

  def up(position)
    x = position.x
    y = position.y - 1
    y >= 1 ? ActiveRecord::Point.new(x,y) : false
  end

  def down(position)
    x = position.x
    y = position.y + 1
    y <= 10 ? ActiveRecord::Point.new(x,y) : false
  end

  def left(position)
    x = position.x - 1
    y = position.y 
    x >= 1 ? ActiveRecord::Point.new(x,y) : false
  end

  def right(position)
    x = position.x + 1
    y = position.y
    x <= 10 ? ActiveRecord::Point.new(x,y) : false
  end 
end
