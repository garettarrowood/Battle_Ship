class MultiplayerController < ApplicationController
  before_action :set_game, only: [:show]

  def create
    # if Game.find(multiplayer?: true, status: "available")
      # join that game
      # @game = that
    # else
      # create new game
      # @game = that
    #end
    # Use Seek to determine what happens here. - some command that hits channel - maybe I don't create a game here??
    @game = "something"
    render js: "window.location = '/multiplayer/#{@game.id}'"
  end

  def show
  end

  private

    def set_game
      @game = Game.find(params[:id])
    end
end
