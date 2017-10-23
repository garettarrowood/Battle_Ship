# frozen_string_literal: true

FactoryGirl.define do
  factory :board do
    game
    owner "comp"
    transient do
      ships_count 1
    end
    before(:create) do |board, evaluator|
      create_list(:patrol_boat, evaluator.ships_count, board: board)
      create_list(:destroyer, evaluator.ships_count, board: board)
      create_list(:submarine, evaluator.ships_count, board: board)
      create_list(:battleship, evaluator.ships_count, board: board)
      create_list(:aircraft_carrier, evaluator.ships_count, board: board)
    end
  end
end
