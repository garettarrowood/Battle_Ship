class Ship < ApplicationRecord
  belongs_to :board
  attribute :positions, :point, array: true

  validates_associated :board
  validates_acceptance_of :adjacent?
  validates_acceptance_of :in_bounds?

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

end
