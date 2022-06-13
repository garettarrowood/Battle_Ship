# frozen_string_literal: true

FactoryBot.define do
  factory :patrol_boat, class: Ship do
    classification { 'Patrol Boat' }
    positions { [ActiveRecord::Point.new(1, 2), ActiveRecord::Point.new(1, 3)] }
    board
  end

  factory :destroyer, class: Ship do
    classification { 'Destroyer' }
    positions { [
      ActiveRecord::Point.new(2, 2),
      ActiveRecord::Point.new(2, 3),
      ActiveRecord::Point.new(2, 4)
    ] }
    board
  end

  factory :submarine, class: Ship do
    classification { 'Submarine' }
    positions { [
      ActiveRecord::Point.new(3, 2),
      ActiveRecord::Point.new(3, 3),
      ActiveRecord::Point.new(3, 4)
    ] }
    board
  end

  factory :battleship, class: Ship do
    classification { 'Battleship' }
    positions { [
      ActiveRecord::Point.new(4, 2),
      ActiveRecord::Point.new(4, 3),
      ActiveRecord::Point.new(4, 4),
      ActiveRecord::Point.new(4, 5)
    ] }
    board
  end

  factory :aircraft_carrier, class: Ship do
    classification { 'Aircraft Carrier' }
    positions { [
      ActiveRecord::Point.new(5, 2),
      ActiveRecord::Point.new(5, 3),
      ActiveRecord::Point.new(5, 4),
      ActiveRecord::Point.new(5, 5),
      ActiveRecord::Point.new(5, 6)
    ] }
    board
  end
end
