# frozen_string_literal: true

class Game < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_games
  has_many :boards, dependent: :delete_all

  validates_associated :users

  after_save :clear_out_old_data, on: :update

  def lost_ships(owner)
    boards.find_by_owner(owner.to_s).sunk_ships.size
  end

  def destroyed_ships(owner)
    boards.where.not(owner: owner.to_s).first.sunk_ships.size
  end

  private

  def clear_out_old_data
    return unless status == 'over'
    two_days_ago = Time.now - 2.days
    Board.where('updated_at <= ?', two_days_ago).destroy_all
    Game.where('updated_at <= ?', two_days_ago).destroy_all
  end
end
