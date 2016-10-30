class CompAI

  x = 1.0
  @@Full_board = []
  10.times do
    y = 1.0
    10.times do
      @@Full_board << ActiveRecord::Point.new(x,y)
      y+=1
    end
    x+=1
  end

  def initialize(board)
    @board = board
    @available_positions = @@Full_board - @board.moves.map(&:position)
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

private

  def analyze
    return "random" if @board.damaging_moves.length == 0
    @last_hit = @board.damaging_moves.sort_by { |move| move.id }.last
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
