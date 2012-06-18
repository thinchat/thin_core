require 'resque'
require 'resque/server'

Resque.redis = 'localhost:6379'

Resque.after_fork = Proc.new {
  ActiveRecord::Base.retrieve_connection
  Resque.redis = Redis.new $resque_redis_config
}
