require 'rails_helper'

RSpec.describe Board, :type => :model do
  let(:opponent_board) { create :board, opponent?: true }
  let(:player_board) { create :board, opponent?: false }
  
  it 'has valid factories' do
    expect(opponent_board).to be_valid
    expect(player_board).to be_valid
  end

  # it 'is not valid without 5 ships' do
  #   board1.ships = []
  #   board1.save!
  #   expect(board1).to be_invalid
  # end

  it 'intializes with 5 placed ships' do
    expect(opponent_board.ships.size).to eq 5
    expect(player_board.ships.size).to eq 5
  end

  context 'belonging to player' do 
    it 'holds visible ships once placed' do
      expect(player_board.ships[0].visible?).to eq true
      expect(player_board.ships[1].visible?).to eq true
      expect(player_board.ships[2].visible?).to eq true
      expect(player_board.ships[3].visible?).to eq true
      expect(player_board.ships[4].visible?).to eq true
    end
  end

  context 'belonging to opponent' do
    it 'holds invisible ships' do
      expect(opponent_board.ships[0].visible?).to eq false
      expect(opponent_board.ships[1].visible?).to eq false
      expect(opponent_board.ships[2].visible?).to eq false
      expect(opponent_board.ships[3].visible?).to eq false
      expect(opponent_board.ships[4].visible?).to eq false
    end
  end

end
