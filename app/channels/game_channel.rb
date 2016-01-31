class GameChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "game-#{data['game_id']}-multiplayer"
  end

  def unfollow
    stop_all_streams
  end

  def make_move(data)
    binding.pry
    # save a move to the server on correct board using data
    # maybe 
    # board = where.not.Board.find_by(owner: current_user.id.to_s)
    # Movelogger(data.coord)
  end
end
