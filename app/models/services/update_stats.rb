class UpdateStats
  def self.user_wins(user, game, lost_ships)
    game.update(winner: user.id,
                status: "over")
    user.update(total_games: user.total_games + 1,
                games_won: user.games_won + 1,
                lost_ships: user.lost_ships + lost_ships,
                enemy_sunk_ships: user.enemy_sunk_ships + 5,
                last_game_result: "Won")
  end

  def self.user_loses(user, game, sunk_ships)
    winner = game.boards.where.not(owner: "#{user.id}")[0].owner

    game.update(winner: winner,
                status: "over")
    user.update(total_games: user.total_games + 1,
                lost_ships: user.lost_ships + 5,
                enemy_sunk_ships: user.enemy_sunk_ships + sunk_ships,
                last_game_result: "Lost")
  end
end
