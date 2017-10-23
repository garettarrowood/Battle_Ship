# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { create :board }

  it 'has valid factories' do
    expect(board).to be_valid
  end

  it "factory has 5 ships" do
    expect(board.ships.size).to eq 5
    board.ships.each do |ship|
      expect(ship).to be_instance_of Ship
    end
  end

  it "#patrol_boat returns board's Patrol Boat ship" do
    expect(board.patrol_boat).to be_instance_of Ship
    expect(board.patrol_boat.classification).to eq "Patrol Boat"
  end

  it "#destroyer returns board's Destroyer ship" do
    expect(board.destroyer).to be_instance_of Ship
    expect(board.destroyer.classification).to eq "Destroyer"
  end

  it "#submarine returns board's Submarine ship" do
    expect(board.submarine).to be_instance_of Ship
    expect(board.submarine.classification).to eq "Submarine"
  end

  it "#battleship returns board's Battleship ship" do
    expect(board.battleship).to be_instance_of Ship
    expect(board.battleship.classification).to eq "Battleship"
  end

  it "#aircraft_carrier returns board's Aircraft Carrier ship" do
    expect(board.aircraft_carrier).to be_instance_of Ship
    expect(board.aircraft_carrier.classification).to eq "Aircraft Carrier"
  end

  describe "#damaging_moves" do
    let!(:occupied1) { create :move,
                       board: board,
                       position: ActiveRecord::Point.new(1.0, 2.0)
                     }
    let!(:occupied2) { create :move,
                       board: board,
                       position: ActiveRecord::Point.new(1.0, 3.0)
                     }
    let!(:unoccupied1) { create :move,
                         board: board,
                         position: ActiveRecord::Point.new(6.0, 8.0)
                       }
    let!(:unoccupied2) { create :move,
                         board: board,
                         position: ActiveRecord::Point.new(6.0, 9.0)
                       }

    it "returns only damaging moves" do
      moves = board.damaging_moves
      expect(moves).to be_instance_of Array
      expect(moves).to include occupied1
      expect(moves).to include occupied2
      expect(moves).to_not include unoccupied1
      expect(moves).to_not include unoccupied2
    end
  end

  describe "#all_ships_sunk?" do
    it "returns true/false if all ships are sunk on one board" do
      expect(board.all_ships_sunk?).to eq false

      Move.create(board: board, position: ActiveRecord::Point.new(1,2))
      Move.create(board: board, position: ActiveRecord::Point.new(1,3))
      Move.create(board: board, position: ActiveRecord::Point.new(2,2))
      Move.create(board: board, position: ActiveRecord::Point.new(2,3))
      Move.create(board: board, position: ActiveRecord::Point.new(2,4))
      Move.create(board: board, position: ActiveRecord::Point.new(3,2))
      Move.create(board: board, position: ActiveRecord::Point.new(3,3))

      expect(board.reload.all_ships_sunk?).to eq false

      Move.create(board: board, position: ActiveRecord::Point.new(3,4))
      Move.create(board: board, position: ActiveRecord::Point.new(4,2))
      Move.create(board: board, position: ActiveRecord::Point.new(4,3))
      Move.create(board: board, position: ActiveRecord::Point.new(4,4))
      Move.create(board: board, position: ActiveRecord::Point.new(4,5))
      Move.create(board: board, position: ActiveRecord::Point.new(5,2))
      Move.create(board: board, position: ActiveRecord::Point.new(5,3))
      Move.create(board: board, position: ActiveRecord::Point.new(5,4))
      Move.create(board: board, position: ActiveRecord::Point.new(5,5))

      expect(board.reload.all_ships_sunk?).to eq false

      Move.create(board: board, position: ActiveRecord::Point.new(5,6))

      expect(board.reload.all_ships_sunk?).to eq true
    end
  end

  describe "#occupied_positions" do
    it "returns positions as Points" do
      positions = board.occupied_positions
      expect(positions).to be_instance_of Array
      expect(positions.first).to be_instance_of ActiveRecord::Point
      expect(positions.length).to eq 17
    end
  end

  describe "#occupied_positions_as_strings" do
    it "returns positions as strings" do
      positions = board.occupied_positions_as_strings
      expect(positions).to be_instance_of Array
      expect(positions.first).to be_instance_of String
      expect(positions.length).to eq 17
    end
  end

  describe "#sinking_move?" do
    it "will return false if given a non-hitting move" do
      miss = Move.create(board: board,
                         position: ActiveRecord::Point.new(8,8))

      expect(board.reload.sinking_move?(miss)).to eq false
    end

    it "will return false if hitting move did not belong to sunk ship" do
      hit = Move.create(board: board,
                        position: ActiveRecord::Point.new(1,3))

      expect(board.reload.sinking_move?(hit)).to eq false
    end

    it "will return true if hitting move sunk a ship" do
      first_hit = Move.create(board: board,
                              position: ActiveRecord::Point.new(1,2))
      sinking_hit = Move.create(board: board,
                                position: ActiveRecord::Point.new(1,3))

      expect(board.reload.sinking_move?(first_hit)).to eq false
      expect(board.sinking_move?(sinking_hit)).to eq true
    end
  end
end
