require 'resque'
require 'resque/server'
require 'redis.rb'

Resque.redis = $redis
