require 'resque'
require 'resque/server'

Resque.redis = 'localhost:6379'
Resque.redis.auth(REDIS_PASSWORD)