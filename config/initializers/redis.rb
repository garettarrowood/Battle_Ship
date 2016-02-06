require "redis"

# uri = URI.parse(ENV["REDISTOGO_URL"])
# REDIS = Redis.new(:url => uri)

REDIS = Redis.new(Rails.application.config_for("cable"))
