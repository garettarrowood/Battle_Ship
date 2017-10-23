# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompAI do
  let(:board) { create :board }

  context "#new_move" do
    it "calls analyze" do
      ai = CompAI.new(board)

      expect(ai).to receive(:analyze)
      ai.new_move
    end

    it "returns a position" do
      position = CompAI.new(board).new_move

      expect(position).to be_instance_of ActiveRecord::Point
    end

    it "returns a position to the left of last hit if its available" do
      Move.create(board: board, position: ActiveRecord::Point.new(5.0,2.0))

      position = CompAI.new(board).new_move
      expect(position).to eq ActiveRecord::Point.new(4.0,2.0)
    end

    it "returns a position below of last hit if the left is taken but below is available" do
      Move.create(board: board, position: ActiveRecord::Point.new(4.0,2.0))
      Move.create(board: board, position: ActiveRecord::Point.new(5.0,2.0))

      position = CompAI.new(board).new_move
      expect(position).to eq ActiveRecord::Point.new(5.0,3.0)
    end

    it "returns a position to the right of last hit if the left and below are taken" do
      Move.create(board: board, position: ActiveRecord::Point.new(5.0,3.0))
      Move.create(board: board, position: ActiveRecord::Point.new(4.0,2.0))
      Move.create(board: board, position: ActiveRecord::Point.new(5.0,2.0))

      position = CompAI.new(board).new_move
      expect(position).to eq ActiveRecord::Point.new(6.0,2.0)
    end

    it "returns a position above of last hit all other adajent positions are taken" do
      Move.create(board: board, position: ActiveRecord::Point.new(6.0,2.0))
      Move.create(board: board, position: ActiveRecord::Point.new(5.0,3.0))
      Move.create(board: board, position: ActiveRecord::Point.new(4.0,2.0))
      Move.create(board: board, position: ActiveRecord::Point.new(5.0,2.0))

      position = CompAI.new(board).new_move
      expect(position).to eq ActiveRecord::Point.new(5.0,1.0)
    end
  end
end
