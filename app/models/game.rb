class Game < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_games
  has_many :boards, dependent: :delete_all

  validates_associated :users
end
