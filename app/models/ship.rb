class Ship < ApplicationRecord
  belongs_to :board
  attribute :positions, :point, array: true
end
