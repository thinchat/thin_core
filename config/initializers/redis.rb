REDIS = Redis.new(:host => 'localhost', :port => 6379)

require "#{Rails.root}/config/secret/redis_password.rb"
REDIS.auth(REDIS_PASSWORD)
