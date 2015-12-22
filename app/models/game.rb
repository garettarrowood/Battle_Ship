class Game < ApplicationRecord
  belongs_to :user # when change to multi-player, should has_and_belongs_to_many users ( or 2 part array of user ids? )
  has_many :boards

  validates_associated :user

  #upon creation of game (with difficulty selected), it should create 2 boards and set ships on opponent board
end
