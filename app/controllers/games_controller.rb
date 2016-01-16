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

  def move
    game = Game.find(params[:game_id])
    @opponent_board = game.boards.where(opponent?: true)[0]
    MoveLogger.new(params[:move], @opponent_board).log!
    @user_board = game.boards.where(opponent?: false)[0]
    @comp_move = CompAI.new(@user_board).new_move
    MoveLogger.new(@comp_move, @user_board).log!
  end

  def load_game
    # this action exists due to a loading issue with the gon gem
    @game = current_user.games.last
    redirect_to @game
  end

end
