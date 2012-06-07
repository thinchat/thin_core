REDIS = Redis.new(:host => 'localhost', :port => 6379)
require 'secret.rb'
REDIS.auth(REDIS_PASSWORD)
