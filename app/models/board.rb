class Board < ApplicationRecord
  belongs_to :game
  has_many :ships
  has_many :moves

  validates_associated :game

end
