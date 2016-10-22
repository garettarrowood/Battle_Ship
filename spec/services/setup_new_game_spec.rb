require 'rails_helper'
require_relative '../../app/models/services/setup_new_game.rb'

RSpec.describe SetupNewGame, :type => :model do
  let(:user) { create :user }
  let(:game) { create :game }
  json = {"0" => {
            "length"=>"2",
            "classification"=>"patrol-boat",
            "positions"=> ["3-5", "3-6"]
          },
          "1" => {
            "length"=>"3",
            "classification"=>"destroyer",
            "positions"=>[ "4-5", "4-6", "4-7"]
          },
          "2" => {
            "length"=>"3", 
            "classification"=>"submarine", 
            "positions"=> ["6-4", "6-5", "6-6"]
          },
          "3" => {
            "length"=>"4",
            "classification"=>"battleship",
            "positions"=> ["8-6", "8-7", "8-8", "8-9"]
          },
          "4" => {
            "length"=>"5",
            "classification"=>"aircraft-carrier",
            "positions"=> ["10-4", "10-5", "10-6", "10-7", "10-8"]
          }
        }

  before(:each) do
    game.users << user
    @game_setup = SetupNewGame.new(json, game, user)
  end

  it "initializes with json and game" do
    expect(@game_setup).to be_instance_of(SetupNewGame)
  end

  it "parses and gathers ship positions upon initialization" do
    expect(@game_setup.patrol_boat).to eq(["3-5", "3-6"])
    expect(@game_setup.destroyer).to eq(["4-5", "4-6", "4-7"])
    expect(@game_setup.submarine).to eq(["6-4", "6-5", "6-6"])
    expect(@game_setup.battleship).to eq(["8-6", "8-7", "8-8", "8-9"])
    expect(@game_setup.aircraft_carrier).to eq(["10-4", "10-5", "10-6", "10-7", "10-8"])
  end

  context "#strings_to_points" do
    before(:each) do
      @positions = @game_setup.patrol_boat
      @points = @game_setup.strings_to_points(@positions)
    end

    it "returns same length array as argument" do
      expect(@positions.length).to eq(@points.length)
    end

    it "morphs String positions into ActiveRecord::Points" do
      expect(@positions[0]).to be_instance_of(String)
      expect(@points[0]).to be_instance_of(ActiveRecord::Point)
    end

    it "changes 1st position number to y coordinate" do
      first_num = @positions[0].scan(/\d/)[0].to_i
      expect(@points[0].y).to eq(first_num)
    end

    it "changes 2nd position number to x coordinate" do
      second_num = @positions[0].scan(/\d/)[1].to_i
      expect(@points[0].x).to eq(second_num)
    end
  end

  context "#create_user_ships" do
    before(:each) do
      @board = game.boards.create(owner: "comp")
      @game_setup.create_user_ships(@board)
    end

    it "adds 5 ships to board" do
      expect(@board.ships.length).to eq(5)
      expect(@board.ships[0]).to be_instance_of(Ship)
    end

    it "only adds 1 of each classification of ship" do
      expect(@board.ships[0].classification).to eq("Patrol Boat")
      expect(@board.ships[1].classification).to eq("Destroyer")
      expect(@board.ships[2].classification).to eq("Submarine")
      expect(@board.ships[3].classification).to eq("Battleship")
      expect(@board.ships[4].classification).to eq("Aircraft Carrier")
    end
  end

  context "#run!" do
    it "creates 2 boards for game" do
      expect(game.boards.length).to eq 0
      @game_setup.run!
      expect(game.boards.length).to eq 2
    end

    it "places 5 ships on each new board" do
      @game_setup.run!
      expect(game.boards[0].ships.length).to eq 5
      expect(game.boards[1].ships.length).to eq 5
    end
  end
end
