REDIS = Redis.new(:host => 'localhost', :port => 6379)
require "#{Rails.root}/config/initializers/secret.rb"
REDIS.auth(REDIS_PASSWORD) if Rails.env == 'production'
