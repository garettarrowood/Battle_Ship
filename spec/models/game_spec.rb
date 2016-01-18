require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) { create :game }
  let(:board) { build :board }
  
  it 'has valid factory' do
    expect(game).to be_valid
  end

  context "#over?" do
    it "returns false if game is not over" do
      expect(game.over?).to eq false
    end

    it "returns true if all ships are sunk on 1 board, and thus the game is over"
  end
end
