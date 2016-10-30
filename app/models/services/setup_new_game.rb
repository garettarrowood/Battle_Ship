class SetupNewGame

  attr_accessor :patrol_boat, :destroyer, :submarine, :battleship, :aircraft_carrier, :game

  def initialize(json, game, user)
    @user = user
    @game = game
    @patrol_boat = json["0"]["positions"]
    @destroyer = json["1"]["positions"]
    @submarine = json["2"]["positions"]
    @battleship = json["3"]["positions"]
    @aircraft_carrier = json["4"]["positions"]
  end

  def run!
    create_user_ships(user_board)

    unless @game.multiplayer?
      GenerateRandomShips.new(comp_board).run!
      @game.status = "ongoing"
      @game.save
    end
  end

  def create_user_ships(board)
    patrol_points = strings_to_points(@patrol_boat)
    board.ships.create(positions: patrol_points,
                       classification: "Patrol Boat")

    destroyer_points = strings_to_points(@destroyer)
    board.ships.create(positions: destroyer_points,
                       classification: "Destroyer")

    sub_points = strings_to_points(@submarine)
    board.ships.create(positions: sub_points,
                       classification: "Submarine")

    battle_points = strings_to_points(@battleship)
    board.ships.create(positions: battle_points,
                       classification: "Battleship")

    carrier_points = strings_to_points(@aircraft_carrier)
    board.ships.create(positions: carrier_points,
                       classification: "Aircraft Carrier")
  end

  def strings_to_points(positions)
    positions.map do |string|
      x = string.split("-")[1].to_i
      y = string.split("-")[0].to_i
      ActiveRecord::Point.new(x,y)
    end
  end

  def user_board
    @user_board ||= @game.boards.create(owner: @user.id.to_s)
  end

  def comp_board
    @comp_board ||= @game.boards.create(owner: "comp")
  end
end
