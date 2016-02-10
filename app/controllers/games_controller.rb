class GamesController < ApplicationController
  before_action :set_game, only: [:show, :move, :won, :lost]
  before_action :set_last_game, only: [:index, :load_game]
  before_filter :authenticate_user!

  def index
    if @game
      @game.status = "over"
      @game.save
      @stats = UserStats.new(current_user, @game)
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create
    SetupNewGame.new(params[:ships], @game, current_user).run!
    render js: "window.location = '/games/#{@game.id}'"
  end

  def show
    @opponent_board = @game.boards.find_by_owner("comp")
    @user_board = @game.boards.find_by_owner("#{current_user.id}")
    gon.jbuilder
  end

  def move
    @opponent_board = @game.boards.find_by_owner("comp")
    MoveLogger.new(params[:move], @opponent_board).log!
    @user_board = @game.boards.find_by_owner("#{current_user.id}")
    @comp_position = CompAI.new(@user_board).new_move
    MoveLogger.new(@comp_position, @user_board).log!
  end

  def load_game # resolves load issue with gon gem
    redirect_to @game
  end

  def won
    @game.winner = current_user.id
    @game.save
    @moves = @game.boards.where.not(owner: "#{current_user.id}")[0].moves.size
    @sunk_ships = @game.boards.find_by_owner("#{current_user.id}").sunk_ships.size
  end

  def lost
    @game.winner = @game.boards.where.not(owner: "#{current_user.id}")[0].owner
    @game.save
    @moves = @game.boards.find_by_owner("#{current_user.id}").moves.size
    @sunk_ships = @game.boards.where.not(owner: "#{current_user.id}")[0].sunk_ships.size
  end

  private

    def set_game
      @game = !!params[:id] ? Game.find(params[:id]) : Game.find(params[:game_id])
    end

    def set_last_game
      @game = current_user.games.last
    end

end
