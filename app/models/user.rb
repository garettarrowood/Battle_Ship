class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :games, join_table: :users_games

  def moves_made(game)
    game.boards.where.not(owner: "#{id}")[0].moves.size
  end
end
