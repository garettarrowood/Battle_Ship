class AddMultiplayerToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :multiplayer?, :boolean, default: false
  end
end
