require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) { create :game }
  
  it 'has valid factory' do
    expect(game).to be_valid
  end
end
