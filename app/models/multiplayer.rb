class Multiplayer

  def self.start(userid1, userid2, gameid)
    Actioncable.server.broadcast(
      "game_#{gameid}_multiplayer_#{userid1}",
      { action: "game_ready",
        mg: userid1
      }
    )

    Actioncable.server.broadcast(
      "game_#{gameid}_multiplayer_#{userid2}",
      { action: "game_ready",
        mg: userid2
      }
    )

    REDIS.set("opponent_for:#{userid1}", userid2)
    REDIS.set("opponent_for:#{userid2}", userid1)
  end

end
