class UserStats
  def self.total_games(user)
    user.games.length
  end

  def self.games_won(user)
    user.games.map { |game| game.boards.where.not(owner: "{current_user.id}")[0] }.find_all { |board| board.sunk_ships.length == 5 if board }.length
  end

  def self.sunk_ships(user)
    user.games.map { |game| game.boards.where(owner: "{current_user.id}")[0] }.map { |board| board.sunk_ships.length }.inject(:+)
  end

  def self.enemy_sunk_ships(user)
    user.games.map { |game| game.boards.where.not(owner: "{current_user.id}")[0] }.map { |board| board ? board.sunk_ships.length : 0 }.inject(:+)
  end

  def self.game_status(game)
    game.boards.where(owner: "{current_user.id}")[0].sunk_ships.length != 5 ? "Won" : "Lost"
  end
end