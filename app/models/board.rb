class Board < ApplicationRecord
  belongs_to :game
  has_many :ships, dependent: :delete_all
  has_many :moves, dependent: :delete_all

  validates_associated :game

  def sunk_ships
    ships.each_with_object([]) do |ship, array|
      array << ship.classification if ship.sunk?
    end
  end

  def all_ships_sunk?
    if sunk_ships.length == 5
      game.status = 'over'
      game.save
      return true
    end
    false
  end

  def damaging_moves
    moves.find_all(&:hit?)
  end

  def sinking_move?(last_hit)
    ship = ships.find { |s| s.positions.include?(last_hit.position) }
    return false unless ship && ship.sunk?
    last_hit == ship_damage(ship).max
  end

  def patrol_boat
    ships.find_by_classification('Patrol Boat')
  end

  def destroyer
    ships.find_by_classification('Destroyer')
  end

  def submarine
    ships.find_by_classification('Submarine')
  end

  def battleship
    ships.find_by_classification('Battleship')
  end

  def aircraft_carrier
    ships.find_by_classification('Aircraft Carrier')
  end

  def occupied_positions
    points = []
    ships.each { |s| points << s.positions } unless ships.empty?
    points.flatten
  end

  def occupied_positions_as_strings
    points = []
    ships.each { |s| points << s.positions_to_strings } unless ships.empty?
    points.flatten
  end

  private

  def ship_damage(ship)
    damaging_moves.find_all { |move| ship.positions.include?(move.position) }
  end
end
