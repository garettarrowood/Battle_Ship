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
    positions = []
    if direction == "horizontal"
      x = (1..6).to_a.sample
      y = (1..10).to_a.sample
      5.times do
        positions << ActiveRecord::Point.new(x,y)
        x+=1
      end
    else
      x = (1..10).to_a.sample
      y = (1..6).to_a.sample
      5.times do
        positions << ActiveRecord::Point.new(x,y)
        y+=1
      end
    end
    @board.ships.create(positions: positions,
                        classification: "Aircraft Carrier")
  end

  def place_battleship
    positions = []
    if direction == "horizontal"
      x = (1..7).to_a.sample.round(2)
      y = (1..10).to_a.sample.round(2)
      4.times do
        positions << ActiveRecord::Point.new(x,y)
        x+=1
      end
    else
      y = (1..7).to_a.sample.round(2)
      x = (1..10).to_a.sample.round(2)
      4.times do
        positions << ActiveRecord::Point.new(x,y)
        y+=1
      end
    end
    return place_battleship if positions & @board.occupied_positions != []
    @board.ships.create(positions: positions,
                        classification: "Battleship")
  end

  def place_submarine
    positions = []
    if direction == "horizontal"
      x = (1..8).to_a.sample.round(2)
      y = (1..10).to_a.sample.round(2)
      3.times do
        positions << ActiveRecord::Point.new(x,y)
        x+=1
      end
    else
      y = (1..8).to_a.sample.round(2)
      x = (1..10).to_a.sample.round(2)
      3.times do
        positions << ActiveRecord::Point.new(x,y)
        y+=1
      end
    end
    return place_submarine if positions & @board.occupied_positions != []
    @board.ships.create(positions: positions,
                        classification: "Submarine")
  end

  def place_destroyer
    positions = []
    if direction == "horizontal"
      x = (1..8).to_a.sample.round(2)
      y = (1..10).to_a.sample.round(2)
      3.times do
        positions << ActiveRecord::Point.new(x,y)
        x+=1
      end
    else
      y = (1..8).to_a.sample.round(2)
      x = (1..10).to_a.sample.round(2)
      3.times do
        positions << ActiveRecord::Point.new(x,y)
        y+=1
      end
    end
    return place_destroyer if positions & @board.occupied_positions != []
    @board.ships.create(positions: positions,
                        classification: "Destroyer")
  end

  def place_patrol_boat
    positions = []
    if direction == "horizontal"
      x = (1..9).to_a.sample.round(2)
      y = (1..10).to_a.sample.round(2)
      2.times do
        positions << ActiveRecord::Point.new(x,y)
        x+=1
      end
    else
      y = (1..9).to_a.sample.round(2)
      x = (1..10).to_a.sample.round(2)
      2.times do
        positions << ActiveRecord::Point.new(x,y)
        y+=1
      end
    end
    return place_patrol_boat if positions & @board.occupied_positions != []
    @board.ships.create(positions: positions,
                        classification: "Patrol Boat")
  end

private

  def direction
    ["horizontal", "vertical"].sample
  end
end
