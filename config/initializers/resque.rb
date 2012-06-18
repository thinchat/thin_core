require 'resque'
require 'resque/server'
require 'config/initializers/redis'

Resque.redis = $redis
