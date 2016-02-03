class AddWinnerToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :winner, :string
  end
end
