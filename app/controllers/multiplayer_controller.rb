class MultiplayerController < ApplicationController
  before_action :set_game, only: [:show]

  def create
    if @game = Game.find_by(multiplayer?: true, status: "pending")
      opponent_id = @game.users[0].id
      @game.status = "ongoing"
      @game.users << current_user 
      @game.save
      user_screenname = current_user.email.split('@')[0]
      SetupNewGame.new(params[:ships], @game, current_user).run!
      ActionCable.server.broadcast "battleship:#{opponent_id}", { action: "go first", name: user_screenname }
    else
      @game = current_user.games.create(multiplayer?: true)
      SetupNewGame.new(params[:ships], @game, current_user).run!
    end
    render js: "window.location = '/multiplayer/#{@game.id}'"
  end

  def show
    @user_board = @game.boards.find_by_owner("#{current_user.id}")
    gon.jbuilder
  end

  def opponent_forfeit
    @game = Game.find(params[:multiplayer_id])
    if @game.status != "over"
      @game.winner = current_user.id
      @game.status = "over"
      @game.save

      opponent_id = @game.users.select {|user| user != current_user }[0].id
      ActionCable.server.broadcast "battleship:#{opponent_id}", { action: "forfeit" }
    end
  end

  def disconnected
    flash[:alert] = "You got disconnected from the game and have been sent back to base."
    redirect_to games_url
  end

  private

    def set_game
      @game = Game.find(params[:id])
    end
end
