class Move < ApplicationRecord
  belongs_to :board
  attribute :position, :point

  validates_presence_of :board
  validates_acceptance_of :uniqueness_checker

  private

  def uniqueness_checker
    board.moves.include?(self) ? false : true
  end
  
end
