require 'rails_helper'

RSpec.describe Ship, :type => :model do
  let(:patrol_boat) { create :patrol_boat }
  let(:destroyer) { create :destroyer }
  let(:submarine) { create :submarine }
  let(:battleship) { create :battleship }
  let(:aircraft_carrier) { create :aircraft_carrier }
  
  it 'has valid factory' do
    expect(patrol_boat).to be_valid
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

  let(:crazy_patroller) { create :patrol_boat, positions: [ActiveRecord::Point.new(1, 1), ActiveRecord::Point.new(4, 9)] }
  let(:crooked_battleship) { create :battleship, positions: [ActiveRecord::Point.new(2,2), ActiveRecord::Point.new(3,2), ActiveRecord::Point.new(4,2), ActiveRecord::Point.new(6,2)]}

  it 'only has linear adjacent positions' do
    expect(battleship.adjacent?).to eq true
    expect(crooked_battleship.adjacent?).to eq false
    expect(patrol_boat.adjacent?).to eq true
    expect(crazy_patroller.adjacent?).to eq false
  end

end
