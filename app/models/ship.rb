class Ship < ApplicationRecord
  belongs_to :board
  attribute :positions, :point, array: true

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
end
