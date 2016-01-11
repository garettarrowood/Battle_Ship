class SetupNewGame

  attr_accessor :patrol_boat, :destroyer, :submarine, :battleship, :aircraft_carrier, :game

  def initialize(json, game)
    @game = game
    @patrol_boat = json["0"]["positions"]
    @destroyer = json["1"]["positions"]
    @submarine = json["2"]["positions"]
    @battleship = json["3"]["positions"]
    @aircraft_carrier = json["4"]["positions"]
    # eventually, also process game difficulty setting, utilizing another model (maybe a service?) for computer board setup and AI strategy
  end

  def run!
    user_board = @game.boards.create(opponent?: false)
    create_user_ships(user_board)
    comp_board = @game.boards.create(opponent?: true)
    GenerateRandomShips.new(comp_board).run!
  end

  def create_user_ships(board)
    patrol_points = strings_to_points(@patrol_boat)
    board.ships.create(positions: patrol_points, classification: "Patrol Boat")

    destroyer_points = strings_to_points(@destroyer)
    board.ships.create(positions: destroyer_points, classification: "Destroyer")

    sub_points = strings_to_points(@submarine)
    board.ships.create(positions: sub_points, classification: "Submarine")

    battle_points = strings_to_points(@battleship)
    board.ships.create(positions: battle_points, classification: "Battleship")

    carrier_points = strings_to_points(@aircraft_carrier)
    board.ships.create(positions: carrier_points, classification: "Aircraft Carrier")
  end

  def strings_to_points(positions)
    positions.map do |string|
      x = string[2].to_i
      y = string[0].to_i
      ActiveRecord::Point.new(x,y)
    end
  end

end
