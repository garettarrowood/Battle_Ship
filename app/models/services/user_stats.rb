class UserStats
  def self.total_games(user)
    user.games.length
  end

  def self.games_won(user)
    user.games.map { |game| game.boards.where(opponent?: true)[0] }.find_all { |board| board.sunk_ships.length == 5 }.length
  end

  def self.sunk_ships(user)
    user.games.map { |game| game.boards.where(opponent?: false)[0] }.map { |board| board.sunk_ships.length }.inject(:+)
  end

  def self.enemy_sunk_ships(user)
    user.games.map { |game| game.boards.where(opponent?: true)[0] }.map { |board| board.sunk_ships.length }.inject(:+)
  end

  def self.game_status(game)
    if game.status == "over"
      game.boards.where(opponent?: true)[0].sunk_ships.length == 5 ? "Won" : "Lost"
    else
      "Still going - Click 'Back to last game'"
    end
  end
end