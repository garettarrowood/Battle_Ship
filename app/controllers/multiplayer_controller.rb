class MultiplayerController < ApplicationController
  before_action :set_game, only: [:show]

  def create
    if @game = Game.find_by(multiplayer?: true, status: "pending")
      opponent_id = @game.users[0].id
      @game.status = "ongoing"
      @game.users << current_user 
      @game.save
      SetupNewGame.new(params[:ships], @game, current_user).run!
      ActionCable.server.broadcast "battleship:#{opponent_id}", { action: "go first" }
    else
      @game = current_user.games.create(multiplayer?: true)
      SetupNewGame.new(params[:ships], @game, current_user).run!
    end
    render js: "window.location = '/multiplayer/#{@game.id}'"
  end

  def show
    @user = current_user
    @user_board = @game.boards.where(owner: "#{current_user.id}")[0]
    set_user_ships(@user_board)
    gon.jbuilder
  end

  def opponent_forfeit
    @game = Game.find(params[:multiplayer_id])
    @game.winner = current_user.id
    @game.save
  end

  private

    def set_game
      @game = Game.find(params[:id])
    end

    def set_user_ships(user_board)
      @user_patrol = user_board.ships.where(classification: "Patrol Boat")[0]
      @user_destroyer = user_board.ships.where(classification: "Destroyer")[0]
      @user_submarine = user_board.ships.where(classification: "Submarine")[0]
      @user_battleship = user_board.ships.where(classification: "Battleship")[0]
      @user_carrier = user_board.ships.where(classification: "Aircraft Carrier")[0]
    end
end
