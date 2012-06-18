require 'resque'
require 'resque/server'
require 'redis.rb'

Resque.redis = Redis.new(:host => 'localhost', :port => 6379)