require 'rails_helper'

RSpec.describe Board, :type => :model do
  let(:board) { create :board }
  # let(:patrol_boat) { build :patrol_boat }
  # let(:destroyer) { build :destroyer }
  # let(:submarine) { build :submarine }
  # let(:battleship) { build :battleship }
  # let(:aircraft_carrier) { build :aircraft_carrier }
  
  it 'has valid factories with 5 placed ships' do
    expect(board).to be_valid
    expect(board.ships.size).to eq 5
  end

  # it "e" do
  #   binding.pry
  # end
end
