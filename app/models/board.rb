class Board < ApplicationRecord
  belongs_to :game
  has_many :ships, dependent: :delete_all
  has_many :moves, dependent: :delete_all

  validates_associated :game
  
  def sunk_ships
    ship_classes = []
    ships.each do |ship|
      ship_classes << ship.classification if ship.sunk?
    end
    ship_classes
  end

  def all_ships_sunk?
    if sunk_ships.length == 5
      game.status = "over"
      game.save
      return true
    end
  end

  def damaging_moves
    moves.find_all { |move| move.hit? }
  end

  def sinking_move?(hitting_move)
    ship = ships.select { |ship| ship.positions.include?(hitting_move.position) }[0]
    return false unless ship.sunk?
    hitting_move == damaging_moves.find_all { |move| ship.positions.include?(move.position) }.max
  end

  def patrol_boat
    ships.find_by_classification("Patrol Boat")
  end

  def destroyer
    ships.find_by_classification("Destroyer")
  end

  def submarine
    ships.find_by_classification("Submarine")
  end

  def battleship
    ships.find_by_classification("Battleship")
  end

  def aircraft_carrier
    ships.find_by_classification("Aircraft Carrier")
  end

  def occupied_positions
    points = []
    ships.each { |ship| points << ship.positions } if ships.length != 0
    points.flatten
  end

  def occupied_positions_as_strings
    points = []
    ships.each { |ship| points << ship.positions_to_strings } if ships.length != 0
    points.flatten
  end
end
