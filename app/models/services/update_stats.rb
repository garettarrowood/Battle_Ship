class UpdateStats
  def self.user_wins(user, game)
    update_winner(game, user.id)

    user.update(total_games: user.total_games + 1,
                games_won: user.games_won + 1,
                lost_ships: user.lost_ships + game.lost_ships(user.id),
                enemy_sunk_ships: user.enemy_sunk_ships + 5,
                last_game_result: "Won")
  end

  def self.user_loses(user, game)
    opponent_id = user.opponent_id(game).to_s
    update_winner(game, opponent_id)

    user.update(total_games: user.total_games + 1,
                lost_ships: user.lost_ships + 5,
                enemy_sunk_ships: user.enemy_sunk_ships + game.destroyed_ships(user.id),
                last_game_result: "Lost")
  end

private

  def self.update_winner(game, winner_id)
    game.update(winner: winner_id, status: "over") if game.status != "over"
  end
end
