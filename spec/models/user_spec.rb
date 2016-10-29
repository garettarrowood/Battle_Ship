require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }
  let(:opponent) { create(:user) }
  let(:user_board) { create(:board, owner: "#{user.id}") }
  let(:pending_online_game) { create(:game, status: "pending", users: [opponent], boards: [user_board]) }
  let(:online_game) { create(:game, users: [user, opponent], boards: [create(:board), user_board]) }
  let(:comp_game) { create(:game, users: [user], boards: [create(:board), user_board]) }
  
  it 'has valid factory' do
    expect(user).to be_valid
  end

  context "#moves_made" do
    it "returns 0 moves when game board unused" do
      expect(user.moves_made(comp_game)).to eq 0
    end

    it "returns number of moves made by user on game board" do
      Move.create(board: user_board,
                  position: ActiveRecord::Point.new(1,2))
      Move.create(board: user_board,
                  position: ActiveRecord::Point.new(8,2))
      Move.create(board: user_board,
                  position: ActiveRecord::Point.new(1,7))

      expect(user.moves_made(comp_game.reload)).to eq 3
    end
  end

  context "#create_multiplayer_game" do
    subject { user.create_multiplayer_game(ships_json) }

    it "creates game" do
      expect{subject}.to change{Game.count}.by(1)
    end

    it "returns game" do
      expect(subject).to be_an_instance_of Game
    end

    it "uses SetupNewGame" do
      expect(SetupNewGame).to receive(:new).and_call_original
      subject
    end
  end

  context "#join_multiplayer_game" do
    subject { user.join_multiplayer_game(ships_json, pending_online_game) }

    it "adds user to game" do
      expect(pending_online_game.users).to_not include user
      expect{subject}.to change{pending_online_game.users.size}.by(1)
      expect(pending_online_game.users).to include user
    end

    it "changes game status to 'ongoing'" do
      expect{subject}.to change{pending_online_game.status}.to "ongoing"
    end

    it "uses SetupNewGame" do
      expect(SetupNewGame).to receive(:new).and_call_original
      subject
    end

    it "broadcasts using ActionCable" do
      expect(ActionCable).to receive(:server).and_call_original
      subject
    end

  end

  context "#opponent_id" do
    it "returns id of opponent when multiplayer game" do
      expect(user.opponent_id(online_game)).to eq opponent.id
    end

    it "returns 'comp' when one player game" do
      expect(user.opponent_id(comp_game)).to eq "comp"
    end
  end

  context "#last_game" do
    let!(:first_game) { create(:game, users: [user])}
    let!(:second_game) { create(:game, users: [user])}
    let!(:last_game) { create(:game, users: [user])}

    it "returns most recently created game" do
      expect(user.last_game).to eq last_game
    end
  end
end
