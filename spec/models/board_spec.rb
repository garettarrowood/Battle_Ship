require 'rails_helper'

RSpec.describe Board, :type => :model do
  let(:board) { create :board }
  
  it 'has valid factories' do
    expect(board).to be_valid
  end

  xit 'is not valid without 5 ships' do
    board.ships.clear
    expect(board).to_not be_valid
  end

  it 'intializes with 5 placed ships' do
    expect(board.ships.size).to eq 5
  end

  context 'belonging to player' do 
    let(:player_board) { create :board, opponent?: false }

    it 'holds visible ships once placed' do
      expect(player_board.ships[0].visible?).to eq true
      expect(player_board.ships[1].visible?).to eq true
      expect(player_board.ships[2].visible?).to eq true
      expect(player_board.ships[3].visible?).to eq true
      expect(player_board.ships[4].visible?).to eq true
    end
  end

  context 'belonging to opponent' do
    let(:opponent_board) { create :board, opponent?: true }

    it 'holds invisible ships' do
      expect(opponent_board.ships[0].visible?).to eq false
      expect(opponent_board.ships[1].visible?).to eq false
      expect(opponent_board.ships[2].visible?).to eq false
      expect(opponent_board.ships[3].visible?).to eq false
      expect(opponent_board.ships[4].visible?).to eq false
    end
  end

end
