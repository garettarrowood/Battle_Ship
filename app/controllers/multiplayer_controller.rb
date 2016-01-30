class MultiplayerController < ApplicationController
  before_action :set_game, only: [:show]

  def create
    if @game = Game.find_by(multiplayer?: true, status: "pending")
      @game.status = "ongoing"
      @game.users << current_user
      @game.save
      SetupNewGame.new(params[:ships], @game, current_user).run!
    else
      @game = current_user.games.create(multiplayer?: true)
      SetupNewGame.new(params[:ships], @game, current_user).run!
    end
    # Use Seek to determine what happens here. - some command that hits channel - maybe I don't create a game here??
    render js: "window.location = '/multiplayer/#{@game.id}'"
  end

  def show
  end

  private

    def set_game
      @game = Game.find(params[:id])
    end
end
