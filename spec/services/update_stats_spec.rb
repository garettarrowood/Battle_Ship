require 'rails_helper'

RSpec.describe UpdateStats do
  let(:user) { create(:user) }
  let(:opponent) { create(:user) }
  let(:game) { create(:game, users: [user, opponent], boards: [create(:board), create(:board, owner: "#{user.id}")]) }

  describe "#user_wins" do
    subject { UpdateStats.user_wins(user, game) }

    it "game#winner is set to user's id" do
      expect{subject}.to change{game.winner}.to "#{user.id}"
    end

    it "game#status is set to 'over'" do
      expect{subject}.to change{game.status}.to "over"
    end

    it "user#total_games goes up by 1" do
      expect{subject}.to change{user.total_games}.by(1)
    end

    it "user#games_won goes up by 1" do
      expect{subject}.to change{user.games_won}.by(1)
    end

    it "user#lost_ships raises by the game's lost_ships" do
      allow(game).to receive(:lost_ships).with(user.id) { 3 }
      expect{subject}.to change{user.lost_ships}.by(3)
    end

    it "user#enemy_sunk_ships goes up by 5" do
      expect{subject}.to change{user.enemy_sunk_ships}.by(5)
    end

    it "user#last_game_result set to 'Won'" do
      expect{subject}.to change{user.last_game_result}.to "Won"
    end
  end

  describe "#user_loses" do
    subject { UpdateStats.user_loses(user, game) }

    it "game#winner is set to opponent's id" do
      expect{subject}.to change{game.winner}.to "#{opponent.id}"
    end

    it "game#status is set to 'over'" do
      expect{subject}.to change{game.status}.to "over"
    end

    it "user#total_games goes up by 1" do
      expect{subject}.to change{user.total_games}.by(1)
    end

    it "user#games_won does not change" do
      expect{subject}.to change{user.games_won}.by(0)
    end

    it "user#enemy_sunk_ships raises by the game's destroyed_ships" do
      allow(game).to receive(:destroyed_ships).with(user.id) { 4 }
      expect{subject}.to change{user.enemy_sunk_ships}.by(4)
    end

    it "user#lost_ships goes up by 5" do
      expect{subject}.to change{user.lost_ships}.by(5)
    end

    it "user#last_game_result set to 'Lost'" do
      expect{subject}.to change{user.last_game_result}.to "Lost"
    end
  end

end
