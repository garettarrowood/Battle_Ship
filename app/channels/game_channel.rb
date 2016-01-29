# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{current_user.id}"
  end

  def unsubscribed
    Seek.remove(id)
  end
end
