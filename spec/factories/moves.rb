# frozen_string_literal: true

FactoryGirl.define do
  factory :move do
    board
    position do
      [
        ActiveRecord::Point.new(1, 2),
        ActiveRecord::Point.new(5, 3),
        ActiveRecord::Point.new(2, 9),
        ActiveRecord::Point.new(8, 1),
        ActiveRecord::Point.new(10, 6)
      ].sample
    end
  end
end
