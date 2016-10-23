require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) { create :game }
  let(:user_board) { create :board, owner: "1", game: game }
  
  it 'has valid factory' do
    expect(game).to be_valid
  end

  context "#status" do
    it "returns 'pending' if game has no sunk ships" do
      expect(game.status).to eq "pending"
    end

    it "returns 'pending' if some but not all ships are sunk" do
      Move.create(board: user_board, position: ActiveRecord::Point.new(1,2))
      Move.create(board: user_board, position: ActiveRecord::Point.new(1,3))
      expect(user_board.ships[0].sunk?).to eq true
      expect(game.status).to eq "pending"
    end

    it "returns 'over' if all ships are sunk on one board" do
      Move.create(board: user_board, position: ActiveRecord::Point.new(1,2))
      Move.create(board: user_board, position: ActiveRecord::Point.new(1,3))
      Move.create(board: user_board, position: ActiveRecord::Point.new(2,2))
      Move.create(board: user_board, position: ActiveRecord::Point.new(2,3))
      Move.create(board: user_board, position: ActiveRecord::Point.new(2,4))
      Move.create(board: user_board, position: ActiveRecord::Point.new(3,2))
      Move.create(board: user_board, position: ActiveRecord::Point.new(3,3))
      Move.create(board: user_board, position: ActiveRecord::Point.new(3,4))
      Move.create(board: user_board, position: ActiveRecord::Point.new(4,2))
      Move.create(board: user_board, position: ActiveRecord::Point.new(4,3))
      Move.create(board: user_board, position: ActiveRecord::Point.new(4,4))
      Move.create(board: user_board, position: ActiveRecord::Point.new(4,5))
      Move.create(board: user_board, position: ActiveRecord::Point.new(5,2))
      Move.create(board: user_board, position: ActiveRecord::Point.new(5,3))
      Move.create(board: user_board, position: ActiveRecord::Point.new(5,4))
      Move.create(board: user_board, position: ActiveRecord::Point.new(5,5))
      Move.create(board: user_board, position: ActiveRecord::Point.new(5,6))
      expect(user_board.all_ships_sunk?).to eq true
      expect(game.status).to eq "over"
    end
  end
end
