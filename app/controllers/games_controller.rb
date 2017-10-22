class GamesController < ApplicationController
  before_action :set_game, only: %i[show move apply_win won apply_loss lost]

  def index; end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create
    SetupNewGame.new(params[:ships], @game, current_user).run!
    render js: "window.location = '/games/#{@game.id}'"
  end

  def show
    @opponent_board = @game.boards.find_by_owner('comp')
    @user_board = @game.boards.find_by_owner(current_user.id.to_s)
    gon.jbuilder
  end

  def move
    @opponent_board = @game.boards.find_by_owner('comp')
    MoveLogger.new(params[:move], @opponent_board).log!
    @user_board = @game.boards.find_by_owner(current_user.id.to_s)
    @comp_position = CompAI.new(@user_board).new_move
    MoveLogger.new(@comp_position, @user_board).log!
  end

  def apply_win
    UpdateStats.user_wins(current_user, @game)
    redirect_to game_won_url
  end

  def won
    @moves = current_user.moves_made(@game)
    @lost_ships = @game.lost_ships(current_user.id)
  end

  def apply_loss
    UpdateStats.user_loses(current_user, @game)
    redirect_to game_lost_url
  end

  def lost
    @moves = current_user.moves_made(@game)
    @destroyed_ships = @game.destroyed_ships(current_user.id)
  end

  private

  def set_game
    @game = !!params[:id] ? Game.find(params[:id]) : Game.find(params[:game_id])
  end
end
