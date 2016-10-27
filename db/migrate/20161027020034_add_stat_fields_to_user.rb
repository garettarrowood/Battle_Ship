class AddStatFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :total_games, :integer, default: 0
    add_column :users, :games_won, :integer, default: 0
    add_column :users, :lost_ships, :integer, default: 0
    add_column :users, :enemy_sunk_ships, :integer, default: 0
    add_column :users, :last_game_result, :string, default: "No games completed yet"
  end
end
