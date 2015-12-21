require 'rails_helper'

RSpec.describe Move, :type => :model do
  let(:move) { build :move }
  
  it 'has valid factory' do
    expect(move).to be_valid
  end
  
end
