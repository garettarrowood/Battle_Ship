class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "battleship:#{current_user.id}"
  end

  def move(data)
    @game = Game.find(data["game_id"])
    opponent_id = @game.users.select {|user| user != current_user }[0].id.to_s
    user_id = current_user.id.to_s
    user_name = current_user.email.split('@')[0]
    opponent_board = @game.boards.where(owner: opponent_id)[0]
    user_board = @game.boards.where(owner: user_id)[0]
    move = MoveLogger.new(data["coord"], opponent_board).log!
    if opponent_board.all_ships_sunk?
      ActionCable.server.broadcast "battleship:#{opponent_id}", { action: "game over", gameId: data["game_id"], winner: false }
      ActionCable.server.broadcast "battleship:#{user_id}", { action: "game over", gameId: data["game_id"], winner: true }
    else
      opponentSunkShips = opponent_board.sunk_ships
      userSunkShips = user_board.sunk_ships
      ActionCable.server.broadcast "battleship:#{opponent_id}", { action: "make move", x: data["x"], y: data["y"], name: user_name }
      move_success = move.hit?
      ActionCable.server.broadcast "battleship:#{user_id}", { action: "move success", move_success: move_success, coord: data["coord"], userSunkShips: userSunkShips, opponentSunkShips: opponentSunkShips }
    end
  end

  def lose(data)
    @game = Game.find(data["game_id"])
    if (@game.status != "over")
      opponent_id = @game.users.select {|user| user != current_user }[0].id.to_s
      ActionCable.server.broadcast "battleship:#{opponent_id}", { action: "opponent disconnect", gameId: data["game_id"] }
    end
  end
end
