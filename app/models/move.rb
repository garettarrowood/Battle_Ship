class Move < ApplicationRecord
  belongs_to :board
  attribute :position, :point

  validates_presence_of :board
  validates_acceptance_of :custom_uniqueness_checker

  private

  def custom_uniqueness_checker
    board.moves.include?(self) ? false : true
  end
  
end
