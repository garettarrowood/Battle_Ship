class GameChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "game_#{data['game_id']}_multiplayer_#{current_user.id}"
  end

  def unfollow
    Seek.remove("#{current_user.id}")
    stop_all_streams
  end
end
