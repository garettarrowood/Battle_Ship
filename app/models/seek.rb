class Seek
  def self.create(id)
    if opponent = REDIS.spop("seeks")
      # start a game - Multiplayer.start(id, opponent, gameid)
      binding.pry
    else
      REDIS.sadd("seeks", id)
    end
  end

  def self.remove(id)
    REDIS.srem("seeks", id)
  end

  def self.clear_all
    REDIS.del("seeks")
  end

end
