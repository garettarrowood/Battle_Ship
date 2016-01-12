class Ship < ApplicationRecord
  belongs_to :board
  attribute :positions, :point, array: true

  validates :classification, :positions, presence: true
  validates_associated :board
  validates_acceptance_of :adjacent?
  validates_acceptance_of :in_bounds?
  validates_acceptance_of :correct_size?

  def visible?
    board.opponent? ? false : true
  end

  def direction
    self.positions[0].x < self.positions[1].x ? "horizontal" : "vertical"
  end

  def positions_to_strings
    positions.map { |point| "#{point.y.round(0).to_s}-#{point.x.round(0).to_s}" }
  end

  private

  def adjacent?
    if positions.map(&:x).uniq.size == 1
      ys = positions.map(&:y).each_cons(2)
      ys.all? { |a,b| b == a + 1 } || ys.all? { |a,b| b == a - 1 }
    elsif positions.map(&:y).uniq.size == 1
      xs = positions.map(&:x).each_cons(2)
      xs.all? { |a,b| b == a + 1 } || xs.all? { |a,b| b == a - 1 }
    else
      false
    end
  end

  def in_bounds?
    positions.map(&:x).all? { |x| x.between?(1,10) } && positions.map(&:y).all? { |y| y.between?(1,10) }
  end

  def correct_size?
    case classification
    when "Patrol Boat" then positions.size == 2
    when "Destroyer" then positions.size == 3
    when "Submarine" then positions.size == 3
    when "Battleship" then positions.size == 4
    when "Aircraft Carrier" then positions.size == 5
    end  
  end
end

class ActiveRecord::Point
  def point_to_px
    [ (x.to_i*32-32).to_s+"px", (y.to_i*32-32).to_s+"px" ]
  end
end
