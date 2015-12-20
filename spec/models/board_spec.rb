require 'rails_helper'

RSpec.describe Board, :type => :model do
  let(:board) { create :board }
  
  it 'has valid factory' do
    expect(board).to be_valid
  end
end
