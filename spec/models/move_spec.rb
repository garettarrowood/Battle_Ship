require 'rails_helper'

RSpec.describe Move, :type => :model do
  let(:move) { build :move }
  
  it 'has valid factory' do
    expect(move).to be_valid
  end

  context "#hit?" do
    occupied_position = ActiveRecord::Point.new(1.0, 2.0)
    unoccupied_position = ActiveRecord::Point.new(6.0, 8.0)
    let(:damaging_move) { build :move, position: occupied_position }
    let(:missing_move) { build :move, position: unoccupied_position }

    it "responds true if move hit a ship" do
      expect(damaging_move.hit?).to eq true
    end

    it "responds false if move missed a ship" do
      expect(missing_move.hit?).to eq false
    end

  end
  
end
