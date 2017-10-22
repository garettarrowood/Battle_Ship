# frozen_string_literal: true

class Ship < ApplicationRecord
  belongs_to :board
  attribute :positions, :point, array: true

  validates :classification, :positions, presence: true
  validates_associated :board
  validates_acceptance_of :adjacent?
  validates_acceptance_of :in_bounds?
  validates_acceptance_of :correct_size?

  def sunk?
    (positions - board.moves.map(&:position)).empty?
  end

  def direction
    positions[0].x < positions[1].x ? 'horizontal' : 'vertical'
  end

  def positions_to_strings
    positions.map { |point| "#{point.y.round(0)}-#{point.x.round(0)}" }
  end

  private

  def adjacent?
    if straight_line_of?(:x)
      make_up_line?(consecutive(:y))
    elsif straight_line_of?(:y)
      make_up_line?(consecutive(:x))
    else
      false
    end
  end

  def straight_line_of?(dimension)
    positions.map { |p| p.send(dimension) }.uniq.size == 1
  end

  def consecutive(dimension)
    positions.map { |p| p.send(dimension) }.each_cons(2)
  end

  def make_up_line?(points)
    points.all? { |a, b| b == a + 1 } || points.all? { |a, b| b == a - 1 }
  end

  def in_bounds?
    x_bound = positions.map(&:x).all? { |x| x.between?(1, 10) }
    y_bound = positions.map(&:y).all? { |y| y.between?(1, 10) }
    x_bound && y_bound
  end

  def correct_size?
    case classification
    when 'Patrol Boat' then positions? 2
    when 'Destroyer' then positions? 3
    when 'Submarine' then positions? 3
    when 'Battleship' then positions? 4
    when 'Aircraft Carrier' then positions? 5
    end
  end

  def positions?(size)
    positions.size == size
  end
end

module ActiveRecord
  class Point
    def point_to_px
      [
        (x.to_i * 32 - 32).to_s + 'px',
        (y.to_i * 32 - 32).to_s + 'px'
      ]
    end
  end
end
