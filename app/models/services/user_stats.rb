class UserStats

  def initialize(user, game)
    @user = user
    @game = game
  end

  def total_games
    @user.games.length
  end

  def games_won
    @user.games.select { |game| game.winner == "#{@user.id}" }.length
  end

  def sunk_ships
    @user.games.map { |game| game.boards.where(owner: @user.id.to_s )[0] }.map { |board| board ? board.sunk_ships.length : 0 }.inject(:+)
  end

  def enemy_sunk_ships
    @user.games.map { |game| game.boards.where.not(owner: @user.id.to_s )[0] }.map { |board| board ? board.sunk_ships.length : 0 }.inject(:+)
  end

  def game_status
    @game.winner == @user.id.to_s ? "Won" : "Lost"
  end
end