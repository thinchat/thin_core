if ENV['RAILS_ENV'] == 'development'
  REDIS_URL = 'localhost'
elsif ENV['RAILS_ENV'] == 'staging'
  REDIS_URL = 'http://50.116.40.131'
elsif ENV['RAILS_ENV'] == 'production'
  REDIS_URL = 'http://thinchat.com'
else
  raise NotImplementedError, "The environment '#{ENV["RAILS_ENV"]}' has no REDIS_URL\n Set one in config/initializers/redis.rb"
end

REDIS = Redis.new(:host => REDIS_URL, :port => 6379)

require "#{Rails.root}/config/secret/redis_password.rb"
REDIS.auth(REDIS_PASSWORD)
