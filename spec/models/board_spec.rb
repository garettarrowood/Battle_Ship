require 'rails_helper'

RSpec.describe Board, :type => :model do
  let(:board) { create :board }
  
  it 'has valid factories with 5 placed ships' do
    expect(board).to be_valid
    expect(board.ships.size).to eq 5
  end
end
