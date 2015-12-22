require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) { create :game }
  
  it 'has valid factory' do
    expect(game).to be_valid
  end

  #upon creation of game (with difficulty selected), it should create 2 boards and set ships on opponent board
end
