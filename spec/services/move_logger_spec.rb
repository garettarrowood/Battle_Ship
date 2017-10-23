# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoveLogger do
  let(:board) { create :board, ships: [] }
  let(:string_coord) { "1-6" }
  let(:coord) { ActiveRecord::Point.new(2.0,3.0) }

  describe "#log!" do
    it "creates move when initialized with coord" do
      MoveLogger.new(coord, board).log!
      expect(board.moves.size).to eq 1
      expect(board.moves.first.position).to eq coord
    end

    it "creates move when initialized with string coord" do
      MoveLogger.new(string_coord, board).log!
      expect(board.moves.size).to eq 1
      expect(board.moves.first.position).to eq ActiveRecord::Point.new(6.0,1.0)
    end
  end
end
