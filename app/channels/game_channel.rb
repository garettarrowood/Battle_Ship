class GameChannel < ApplicationCable::Channel

  def subscribed
    stream_from "battleship:#{current_user.id}"
  end

  def move(data)
    @game = Game.find(data["game_id"])
    @move = make_move(data["coord"])

    unless opponent_board.all_ships_sunk?
      keep_playing(data["coord"], data["x"], data["y"])
    else
      game_over
    end
  end

  def disconnect(data)
    @game = Game.find(data["game_id"])
    disconnection_notification
  end

private

  def opponent_id
    @opponent_id ||= @game.users.select {|user| user != current_user }.first.id
  end

  def user_id
    @user_id ||= current_user.id
  end

  def user_name 
    @user_name ||= current_user.email.split('@').first
  end

  def opponent_board
    @game.boards.where(owner: opponent_id.to_s).first
  end

  def user_board
    @game.boards.where(owner: user_id.to_s).first
  end

  def make_move(coord)
    MoveLogger.new(coord, opponent_board).log!
  end

  def keep_playing(coord, x, y)
    opponentSunkShips = opponent_board.sunk_ships
    userSunkShips = user_board.sunk_ships
    move_success = @move.hit?

    ActionCable.server.broadcast(
      "battleship:#{opponent_id}", 
      { action: "make move", 
        x: x, 
        y: y, 
        name: user_name 
      }
    )

    ActionCable.server.broadcast(
      "battleship:#{user_id}", 
      { action: "move success", 
        move_success: move_success, 
        coord: coord, 
        userSunkShips: userSunkShips, 
        opponentSunkShips: opponentSunkShips 
      }
    )
  end

  def game_over
    ActionCable.server.broadcast(
      "battleship:#{opponent_id}", 
      { action: "game over", 
        gameId: @game.id, 
        winner: false 
      }
    )

    ActionCable.server.broadcast(
      "battleship:#{user_id}", 
      { action: "game over", 
        gameId: @game.id, 
        winner: true 
      }
    )
  end

  def disconnection_notification
    if @game.status != "over"
      ActionCable.server.broadcast(
        "battleship:#{opponent_id}", 
        { action: "opponent disconnect", 
          gameId: @game.id
        }
      )
    end
  end
end
