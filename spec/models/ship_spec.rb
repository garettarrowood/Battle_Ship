require 'rails_helper'

RSpec.describe Ship, :type => :model do
  let(:patrol_boat) { build :patrol_boat }
  let(:destroyer) { build :destroyer }
  let(:submarine) { build :submarine }
  let(:battleship) { build :battleship }
  let(:aircraft_carrier) { build :aircraft_carrier }
  
  it 'has valid factories' do
    expect(patrol_boat).to be_valid
    expect(destroyer).to be_valid
    expect(submarine).to be_valid
    expect(battleship).to be_valid
    expect(aircraft_carrier).to be_valid
  end

  it 'has to have classification' do
    destroyer.classification = nil
    expect(destroyer).to_not be_valid
  end

  it 'must belong to board' do
    submarine.board_id = nil
    expect(submarine).to_not be_valid
  end

  let(:crazy_patroller) { build :patrol_boat, positions: [ActiveRecord::Point.new(1, 1), ActiveRecord::Point.new(4, 9)] }
  let(:crooked_battleship) { build :battleship, positions: [ActiveRecord::Point.new(2,2), ActiveRecord::Point.new(3,2), ActiveRecord::Point.new(4,2), ActiveRecord::Point.new(6,2)]}

  it 'only has consecutive adjacent positions' do
    expect(crooked_battleship.valid?).to eq false
    expect(crazy_patroller.valid?).to eq false
  end

  let(:jumping_submarine) { build :submarine, positions: [ActiveRecord::Point.new(3,9), ActiveRecord::Point.new(3,10), ActiveRecord::Point.new(3,11)] }
  let(:renagade_destroyer) { build :destroyer, positions: [ActiveRecord::Point.new(1,2), ActiveRecord::Point.new(0,3), ActiveRecord::Point.new(-1,4)]}

  it 'only has positions on the 10x10 board' do
    expect(jumping_submarine.valid?).to eq false
    expect(renagade_destroyer.valid?).to eq false
  end

  context 'has size of' do
    it '2 positions if a Patrol Boat' do 
      expect(patrol_boat.positions.size).to eq 2
    end

    it '3 positions if a Destroyer' do 
      expect(destroyer.positions.size).to eq 3
    end

    it '3 positions if a Submarine' do 
      expect(submarine.positions.size).to eq 3
    end

    it '4 positions if a Battleship' do 
      expect(battleship.positions.size).to eq 4
    end

    it '5 positions if an Aircraft Carrier' do 
      expect(aircraft_carrier.positions.size).to eq 5
    end  
  end

  context "#sunk?" do
    it "returns false if ship is afloat" do
      patrol_boat.save
      expect(patrol_boat.sunk?).to eq false
    end

    it "returns true if ship is sunk" do
      patrol_boat.save
      patrol_boat.board.moves.create(position: ActiveRecord::Point.new(1.0,2.0))
      patrol_boat.board.moves.create(position: ActiveRecord::Point.new(1.0,3.0))
      expect(patrol_boat.sunk?).to eq true
    end
  end

  context "#direction" do
    let(:vertical_patrol) { build :patrol_boat }
    let(:horizontal_patrol) { build :patrol_boat, positions: [ActiveRecord::Point.new(8, 5), ActiveRecord::Point.new(9, 5)]}

    it "returns whether ship is placed horizontal or vertical" do
      expect(vertical_patrol.direction).to eq "vertical"
      expect(horizontal_patrol.direction).to eq "horizontal"
    end
  end

  context "#positions_to_strings" do
    let(:stringy_patrol) { build :patrol_boat, positions: [ActiveRecord::Point.new(8, 5), ActiveRecord::Point.new(9, 5)]}

    it "returns all ship positions as 'y-x' instead of point datatypes" do
      expect(stringy_patrol.positions_to_strings).to eq(["5-8", "5-9"])
    end
  end

  context "ActiveRecord::Point#point_to_px" do
    point1 = ActiveRecord::Point.new(1, 1)
    point2 = ActiveRecord::Point.new(9, 5)

    it "returns array of px coords" do
      expect(point1.point_to_px).to eq(["0px", "0px"])
      expect(point2.point_to_px).to eq(["256px", "128px"])
    end
  end
end
