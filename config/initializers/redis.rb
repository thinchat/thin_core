if Rails.env == 'development'
  REDIS_URL = 'localhost'
elsif Rails.env == 'staging'
  REDIS_URL = 'http://50.116.40.131'
elsif Rails.env == 'production'
  REDIS_URL = 'http://thinchat.com'
else
  raise NotImplementedError, "The environment '#{Rails.env}' has no REDIS_URL\n Set one in config/initializers/redis.rb"
end

REDIS = Redis.new(:host => REDIS_URL, :port => 6379)

require "#{Rails.root}/config/secret/redis_password.rb"
REDIS.auth(REDIS_PASSWORD)
