class CreateUsersGames < ActiveRecord::Migration[5.0]
  def change
    create_table :users_games do |t|
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true
    end
  end
end
