require 'rails_helper'

RSpec.describe GenerateRandomShips do
  let(:board) { create :board, ships: [] }

  before(:each) do
    @random_setup = GenerateRandomShips.new(board)
  end

  it "initializes with board" do
    expect(@random_setup).to be_instance_of(GenerateRandomShips)
  end

  context "#place_aircraft_carrier" do
    it "adds ship with classification 'Aircraft Carrier' of 5 positions to board" do
      expect(board.ships.length).to eq(0)
      @random_setup.place_aircraft_carrier
      expect(board.ships.length).to eq(1)
      expect(board.ships[0].classification).to eq("Aircraft Carrier")
      expect(board.ships[0].positions.length).to eq(5)
    end

    it "all ship positions are unique" do
      @random_setup.place_aircraft_carrier
      expect(board.occupied_positions.uniq.length).to eq(5)
    end
  end

  context "#place_battleship" do
    before(:each) do
      @random_setup.place_aircraft_carrier
    end

    it "adds ship with classification 'Battleship' of 4 positions to board" do
      expect(board.ships.length).to eq(1)
      @random_setup.place_battleship
      expect(board.ships.length).to eq(2)
      expect(board.ships[1].classification).to eq("Battleship")
      expect(board.ships[1].positions.length).to eq(4)
    end

    it "adds 4 more occupied_positions to board" do
      expect { @random_setup.place_battleship }.to change{board.occupied_positions.length}.from(5).to(9)
    end

    it "does not add any overlapping positions" do
      @random_setup.place_battleship
      expect(board.occupied_positions.uniq.length).to eq(9)
    end
  end

  context "#place_submarine" do
    before(:each) do
      @random_setup.place_aircraft_carrier
      @random_setup.place_battleship
    end

    it "adds ship with classification 'Submarine' of 3 positions to board" do
      expect(board.ships.length).to eq(2)
      @random_setup.place_submarine
      expect(board.ships.length).to eq(3)
      expect(board.ships[2].classification).to eq("Submarine")
      expect(board.ships[2].positions.length).to eq(3)
    end

    it "adds 4 more occupied_positions to board" do
      expect { @random_setup.place_submarine }.to change{board.occupied_positions.length}.from(9).to(12)
    end

    it "does not add any overlapping positions" do
      @random_setup.place_submarine
      expect(board.occupied_positions.uniq.length).to eq(12)
    end
  end

  context "#place_destroyer" do
    before(:each) do
      @random_setup.place_aircraft_carrier
      @random_setup.place_battleship
      @random_setup.place_submarine
    end

    it "adds ship with classification 'Destroyer' of 3 positions to board" do
      expect(board.ships.length).to eq(3)
      @random_setup.place_destroyer
      expect(board.ships.length).to eq(4)
      expect(board.ships[3].classification).to eq("Destroyer")
      expect(board.ships[3].positions.length).to eq(3)
    end

    it "adds 4 more occupied_positions to board" do
      expect { @random_setup.place_destroyer }.to change{board.occupied_positions.length}.from(12).to(15)
    end

    it "does not add any overlapping positions" do
      @random_setup.place_destroyer
      expect(board.occupied_positions.uniq.length).to eq(15)
    end
  end

  context "#place_patrol_boat" do
    before(:each) do
      @random_setup.place_aircraft_carrier
      @random_setup.place_battleship
      @random_setup.place_submarine
      @random_setup.place_destroyer
    end

    it "adds ship with classification 'Patrol Boat' of 2 positions to board" do
      expect(board.ships.length).to eq(4)
      @random_setup.place_patrol_boat
      expect(board.ships.length).to eq(5)
      expect(board.ships[4].classification).to eq("Patrol Boat")
      expect(board.ships[4].positions.length).to eq(2)
    end

    it "adds 4 more occupied_positions to board" do
      expect { @random_setup.place_patrol_boat }.to change{board.occupied_positions.length}.from(15).to(17)
    end

    it "does not add any overlapping positions" do
      @random_setup.place_patrol_boat
      expect(board.occupied_positions.uniq.length).to eq(17)
    end
  end

  context "#run!" do 
    it "should receive all place_{ship} methods" do
      expect(@random_setup).to receive(:place_aircraft_carrier)
      expect(@random_setup).to receive(:place_battleship)
      expect(@random_setup).to receive(:place_submarine)
      expect(@random_setup).to receive(:place_destroyer)
      expect(@random_setup).to receive(:place_patrol_boat)
      @random_setup.run!
    end
  end
end
