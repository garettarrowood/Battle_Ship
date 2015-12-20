class Move < ApplicationRecord
  belongs_to :board

  attribute :position, :point
  
end
