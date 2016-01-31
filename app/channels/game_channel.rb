class GameChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "game #{data['game_id']} against user #{current_user.id}"
  end

  def unfollow
    stop_all_streams
  end

  def move(data)
    @game = Game.find(data["game_id"])
    opponent_id = @game.users.select {|user| user != current_user }[0].id.to_s
    user_id = current_user.id.to_s
    opponent_board = @game.boards.where(owner: opponent_id)[0]
    user_board = @game.boards.where(owner: user_id)[0]
    move = MoveLogger.new(data["coord"], opponent_board).log!
    if opponent_board.all_ships_sunk?
      ActionCable.server.broadcast "game #{data["game_id"]} against user #{opponent_id}", { action: "game over", gameId: data["game_id"], winner: false }
      ActionCable.server.broadcast "game #{data["game_id"]} against user #{user_id}", { action: "game over", gameId: data["game_id"], winner: true }
    else
      opponentSunkShips = opponent_board.sunk_ships
      userSunkShips = user_board.sunk_ships
      ActionCable.server.broadcast "game #{data["game_id"]} against user #{opponent_id}", { action: "make move", x: data["x"], y: data["y"] }
      move_success = move.hit?
      ActionCable.server.broadcast "game #{data["game_id"]} against user #{user_id}", { action: "move success", move_success: move_success, coord: data["coord"], userSunkShips: userSunkShips, opponentSunkShips: opponentSunkShips }
    end
  end
end
