# frozen_string_literal: true

class SetupNewGame
  attr_accessor :patrol_boat, :destroyer, :submarine
  attr_accessor :battleship, :aircraft_carrier, :game

  def initialize(json, game, user)
    @user = user
    @game = game
    @patrol_boat = json['0']['positions']
    @destroyer = json['1']['positions']
    @submarine = json['2']['positions']
    @battleship = json['3']['positions']
    @aircraft_carrier = json['4']['positions']
  end

  def run!
    create_user_ships(user_board)
    return if @game.multiplayer?

    GenerateRandomShips.new(comp_board).run!
    @game.status = 'ongoing'
    @game.save
  end

  def create_user_ships(board)
    board.ships.create(positions: strings_to_points(@patrol_boat),
                       classification: 'Patrol Boat')

    board.ships.create(positions: strings_to_points(@destroyer),
                       classification: 'Destroyer')

    board.ships.create(positions: strings_to_points(@submarine),
                       classification: 'Submarine')

    board.ships.create(positions: strings_to_points(@battleship),
                       classification: 'Battleship')

    board.ships.create(positions: strings_to_points(@aircraft_carrier),
                       classification: 'Aircraft Carrier')
  end

  def strings_to_points(positions)
    positions.map do |string|
      x = string.split('-')[1].to_i
      y = string.split('-')[0].to_i
      ActiveRecord::Point.new(x, y)
    end
  end

  def user_board
    @user_board ||= @game.boards.create(owner: @user.id.to_s)
  end

  def comp_board
    @comp_board ||= @game.boards.create(owner: 'comp')
  end
end
