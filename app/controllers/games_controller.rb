class GamesController < ApplicationController
  before_action :set_game, only: [:show, :move, :won, :lost]
  before_action :set_last_game, only: [:index, :load_game]
  before_filter :authenticate_user!

  def index
    @total_games = UserStats.total_games(current_user)
    @games_won = UserStats.games_won(current_user)
    @your_sunk_ships = UserStats.sunk_ships(current_user)
    @enemy_sunk_ships = UserStats.sunk_ships(current_user)
    @last_game_status = UserStats.game_status(@game)
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
    @opponent_board = @game.boards.where(opponent?: true)[0]
    @user_board = @game.boards.where(opponent?: false)[0]
    gon.jbuilder
  end

  def move
    @opponent_board = @game.boards.where(opponent?: true)[0]
    MoveLogger.new(params[:move], @opponent_board).log!
    @user_board = @game.boards.where(opponent?: false)[0]
    @comp_position = CompAI.new(@user_board).new_move
    MoveLogger.new(@comp_position, @user_board).log!
  end

  def load_game # resolves load issue with gon gem
    redirect_to @game
  end

  def won
    @moves = @game.boards.where(opponent?: false)[0].moves.length
    @sunk_ships = @game.boards.where(opponent?: false)[0].sunk_ships.length
  end

  def lost
    @moves = @game.boards.where(opponent?: false)[0].moves.length
    @sunk_ships = @game.boards.where(opponent?: true)[0].sunk_ships.length
  end

  private

  def set_game
    @game = !!params[:id] ? Game.find(params[:id]) : Game.find(params[:game_id])
  end

  def set_last_game
    @game = current_user.games.last
  end

end
