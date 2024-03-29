# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    game
    owner { 'comp' }
    transient { ships_count { 1 } }
    after(:create) do |board, evaluator|
      create_list(:patrol_boat, evaluator.ships_count, board: board)
      create_list(:destroyer, evaluator.ships_count, board: board)
      create_list(:submarine, evaluator.ships_count, board: board)
      create_list(:battleship, evaluator.ships_count, board: board)
      create_list(:aircraft_carrier, evaluator.ships_count, board: board)
    end
  end
end
