class Move < ApplicationRecord
  belongs_to :board
  attribute :position, :point

  validates :position, presence: true
  validates_associated :board
  validates_acceptance_of :uniqueness_checker

  def hit?
    board.occupied_positions.include?(position)
  end

  private

  def uniqueness_checker
    board.moves.include?(self) ? false : true
  end
end
