class MultiplayerController < ApplicationController
  before_action :set_game, only: [:show]

  def create
    if (@game = Game.find_by(multiplayer?: true, status: 'pending'))
      current_user.join_multiplayer_game(params[:ships], @game)
    else
      @game = current_user.create_multiplayer_game(params[:ships])
    end
    render js: "window.location = '/multiplayer/#{@game.id}'"
  end

  def show
    @user_board = @game.boards.find_by_owner current_user.id.to_s
    gon.jbuilder
  end

  def opponent_forfeit
    @game = Game.find(params[:multiplayer_id])
    return if @game.status == 'over'
    UpdateStats.user_wins(current_user, @game)

    ActionCable.server.broadcast(
      "battleship:#{current_user.opponent_id(@game)}",
      action: 'forfeit'
    )
  end

  def disconnected
    flash[:alert] = 'You disconnected from the game and are back at the base.'
    UpdateStats.user_loses(current_user, current_user.last_game)
    redirect_to games_url
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
