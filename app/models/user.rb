class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :games, join_table: :users_games

  def moves_made(game)
    board = game.boards.find_by_owner("#{id}")
    board.present? ? board.moves.size : 0
  end

  def create_multiplayer_game(ships)
    game = games.create(multiplayer?: true)
    SetupNewGame.new(ships, game, self).run!
    game
  end

  def join_multiplayer_game(ships, game)
    game.status = "ongoing"
    game.users << self
    game.save

    SetupNewGame.new(ships, game, self).run!
    broadcast_start(game)
  end

  def opponent_id(game)
    opponent = game.users.where.not(id: id).first
    opponent.present? ? opponent.id : "comp"
  end

  def last_game
    games.max
  end

private

  def broadcast_start(game)
    ActionCable.server.broadcast(
      "battleship:#{opponent_id(game)}",
      { action: "go first",
        name: email.split('@').first
      }
    )
  end
end
