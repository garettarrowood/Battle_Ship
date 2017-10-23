# frozen_string_literal: true

class CompAI
  def self.full_board # rubocop:disable Metrics/MethodLength
    @full_board ||= begin
      x = 1.0
      board = []
      10.times do
        y = 1.0
        10.times do
          board << ActiveRecord::Point.new(x, y)
          y += 1
        end
        x += 1
      end
      board
    end
  end

  def initialize(board)
    @board = board
    @available_positions = CompAI.full_board - @board.moves.map(&:position)
  end

  # returns a position
  def new_move
    case analyze
    when 'random'
      @available_positions.sample
    when 'educated guess'
      guess = guess_based_on(@last_hit.position)
      return guess if guess.present?
      guess = guess_based_on(damaging_move(-2).position)
      return guess if guess.present?
      @available_positions.sample
    end
  end

  private

  def damaging_move(index)
    @board.damaging_moves.sort_by(&:id)[index]
  end

  def guess_based_on(hit)
    return left(hit) if @available_positions.include?(left(hit))
    return down(hit) if @available_positions.include?(down(hit))
    return right(hit) if @available_positions.include?(right(hit))
    return up(hit) if @available_positions.include?(up(hit))
    nil
  end

  def analyze
    return 'random' if @board.damaging_moves.empty?
    @last_hit = damaging_move(-1)
    return 'random' if @board.sinking_move?(@last_hit)
    'educated guess'
  end

  def up(position)
    x = position.x
    y = position.y - 1
    y >= 1 ? ActiveRecord::Point.new(x, y) : false
  end

  def down(position)
    x = position.x
    y = position.y + 1
    y <= 10 ? ActiveRecord::Point.new(x, y) : false
  end

  def left(position)
    x = position.x - 1
    y = position.y
    x >= 1 ? ActiveRecord::Point.new(x, y) : false
  end

  def right(position)
    x = position.x + 1
    y = position.y
    x <= 10 ? ActiveRecord::Point.new(x, y) : false
  end
end
