require 'rails_helper'

RSpec.describe Ship, :type => :model do
  let(:patrol_boat) { create :patrol_boat }
  let(:destroyer) { create :destroyer }
  let(:submarine) { create :submarine }
  let(:battleship) { create :battleship }
  let(:aircraft_carrier) { create :aircraft_carrier }
  
  it 'has valid factories' do
    expect(patrol_boat).to be_valid
    expect(destroyer).to be_valid
    expect(submarine).to be_valid
    expect(battleship).to be_valid
    expect(aircraft_carrier).to be_valid
  end

  context 'has length of' do
    it '2 positions if type is Patrol Boat' do 
      expect(patrol_boat.positions.size).to eq 2
    end

    it '3 positions if type is Destroyer' do 
      expect(destroyer.positions.size).to eq 3
    end

    it '3 positions if type is Submarine' do 
      expect(submarine.positions.size).to eq 3
    end

    it '4 positions if type is Battleship' do 
      expect(battleship.positions.size).to eq 4
    end

    it '5 positions if type is Aircraft Carrier' do 
      expect(aircraft_carrier.positions.size).to eq 5
    end  
  end

  let(:crazy_patroller) { build :patrol_boat, positions: [ActiveRecord::Point.new(1, 1), ActiveRecord::Point.new(4, 9)] }
  let(:crooked_battleship) { build :battleship, positions: [ActiveRecord::Point.new(2,2), ActiveRecord::Point.new(3,2), ActiveRecord::Point.new(4,2), ActiveRecord::Point.new(6,2)]}

  it 'is only valid with consecutive adjacent positions' do
    expect(crooked_battleship.valid?).to eq false
    expect(crazy_patroller.valid?).to eq false
  end

  let(:jumping_submarine) { build :submarine, positions: [ActiveRecord::Point.new(3,9), ActiveRecord::Point.new(3,10), ActiveRecord::Point.new(3,11)] }
  let(:renagade_destroyer) { build :destroyer, positions: [ActiveRecord::Point.new(1,2), ActiveRecord::Point.new(0,3), ActiveRecord::Point.new(-1,4)]}

  it 'must only have positions on the 10x10 board' do
    expect(jumping_submarine.valid?).to eq false
    expect(renagade_destroyer.valid?).to eq false
  end

end
