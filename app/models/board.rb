class Board < ApplicationRecord
  belongs_to :game
  has_many :ships, dependent: :delete_all
  has_many :moves, dependent: :delete_all

  validates_associated :game

end
