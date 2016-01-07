class GamesController < ApplicationController

  def index
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create()
    SetupNewGame.new(params[:ships], @game).run!
    render js: "window.location = '/games/#{@game.id}'"
  end

  def show
  end

end
