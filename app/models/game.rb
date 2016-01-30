class Game < ApplicationRecord
  belongs_to :user # when change to multi-player, should has_and_belongs_to_many users ( or 2 part array of user ids? )
  has_many :boards, dependent: :delete_all

  validates_associated :user
end
