class Board < ApplicationRecord
  belongs_to :game
  has_many :ships, dependent: :delete_all
  has_many :moves, dependent: :delete_all

  validates_associated :game

  def patrol_boat
    ships.where(classification: "Patrol Boat")[0]
  end

  def destroyer
    ships.where(classification: "Destroyer")[0]
  end

  def submarine
    ships.where(classification: "Submarine")[0]
  end

  def battleship
    ships.where(classification: "Battleship")[0]
  end

  def aircraft_carrier
    ships.where(classification: "Aircraft Carrier")[0]
  end

  def occupied_positions
    points = []
    ships.each { |ship| points << ship.positions } if ships.length != 0
    points.flatten
  end

end
