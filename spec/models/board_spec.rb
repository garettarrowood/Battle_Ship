require 'rails_helper'

RSpec.describe Board, :type => :model do
  let(:board) { create :board }
  
  it 'has valid factories with 5 placed ships' do
    expect(board).to be_valid
    expect(board.ships.size).to eq 5
  end

  context 'belonging to player' do 
    let(:player_board) { create :board, opponent?: false }

    it 'holds visible ships once placed' do
      expect(player_board.patrol_boat.visible?).to eq true
      expect(player_board.destroyer.visible?).to eq true
      expect(player_board.submarine.visible?).to eq true
      expect(player_board.battleship.visible?).to eq true
      expect(player_board.aircraft_carrier.visible?).to eq true
    end
  end

  context 'belonging to opponent' do
    let(:opponent_board) { create :board, opponent?: true }

    it 'holds invisible ships' do
      expect(opponent_board.patrol_boat.visible?).to eq false
      expect(opponent_board.destroyer.visible?).to eq false
      expect(opponent_board.submarine.visible?).to eq false
      expect(opponent_board.battleship.visible?).to eq false
      expect(opponent_board.aircraft_carrier.visible?).to eq false
    end
  end

end
