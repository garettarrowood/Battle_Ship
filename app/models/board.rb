class Board < ApplicationRecord
  belongs_to :game
  has_many :ships
  has_many :moves
end
