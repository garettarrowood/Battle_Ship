class Game < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_games
  has_many :boards, dependent: :delete_all

  validates_associated :users

  def lost_ships(owner)
    boards.find_by_owner(owner.to_s).sunk_ships.size
  end

  def destroyed_ships(owner)
    boards.where.not(owner: owner.to_s).first.sunk_ships.size
  end
end
