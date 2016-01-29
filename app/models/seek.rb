class Seek
  def self.create(id)
    if opponent = REDIS.spop("seeks")
      # start a game - passing in a the id and the opponent
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
