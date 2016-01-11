class GamesController < ApplicationController

  def index
    @game = current_user.games.last
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create
    SetupNewGame.new(params[:ships], @game).run!
    render js: "window.location = '/games/#{@game.id}'"
  end

  def show
    @opponent_board = Game.find(params[:id]).boards.where(opponent?: true)[0]
    @user_board = Game.find(params[:id]).boards.where(opponent?: false)[0]
    gon.jbuilder
  end

end
