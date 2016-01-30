class MultiplayerController < ApplicationController
  before_action :set_game

  def index
  end

  def create
    binding.pry
  end

  private

    def set_game
      @game = Game.find(params[:game_id])
    end
end
