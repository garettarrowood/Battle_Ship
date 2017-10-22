class GenerateRandomShips
  def initialize(board)
    @board = board
  end

  def run!
    place_aircraft_carrier
    place_battleship
    place_submarine
    place_destroyer
    place_patrol_boat
  end

  def place_aircraft_carrier
    if horizontal? # rubocop:disable Style/ConditionalAssignment
      points = horizontal_positions(times: 5, x: upto(6), y: upto(10))
    else
      points = vertical_positions(times: 5, x: upto(10), y: upto(6))
    end
    @board.ships.create(positions: points, classification: 'Aircraft Carrier')
  end

  def place_battleship
    if horizontal? # rubocop:disable Style/ConditionalAssignment
      points = horizontal_positions(times: 4, x: upto(7), y: upto(10))
    else
      points = vertical_positions(times: 4, x: upto(10), y: upto(7))
    end
    return place_battleship if overlap?(points)
    @board.ships.create(positions: points, classification: 'Battleship')
  end

  def place_submarine
    if horizontal? # rubocop:disable Style/ConditionalAssignment
      points = horizontal_positions(times: 3, x: upto(8), y: upto(10))
    else
      points = vertical_positions(times: 3, x: upto(10), y: upto(8))
    end
    return place_submarine if overlap?(points)
    @board.ships.create(positions: points, classification: 'Submarine')
  end

  def place_destroyer
    if horizontal? # rubocop:disable Style/ConditionalAssignment
      points = horizontal_positions(times: 3, x: upto(8), y: upto(10))
    else
      points = vertical_positions(times: 3, x: upto(10), y: upto(8))
    end
    return place_destroyer if overlap?(points)
    @board.ships.create(positions: points, classification: 'Destroyer')
  end

  def place_patrol_boat
    if horizontal? # rubocop:disable Style/ConditionalAssignment
      points = horizontal_positions(times: 2, x: upto(9), y: upto(10))
    else
      points = vertical_positions(times: 2, x: upto(10), y: upto(9))
    end
    return place_patrol_boat if overlap?(points)
    @board.ships.create(positions: points, classification: 'Patrol Boat')
  end

  private

  def horizontal?
    [true, false].sample
  end

  def upto(max)
    (1..max).to_a.sample.to_f
  end

  def horizontal_positions(times:, x:, y:)
    positions = []
    times.times do
      positions << ActiveRecord::Point.new(x, y)
      x += 1
    end
    positions
  end

  def vertical_positions(times:, x:, y:)
    positions = []
    times.times do
      positions << ActiveRecord::Point.new(x, y)
      y += 1
    end
    positions
  end

  def overlap?(positions)
    positions & @board.occupied_positions != []
  end
end
