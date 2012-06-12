if Rails.env == 'production'
  REDIS_URL = 'http://thinchat.com'
elsif Rails.env == 'staging'
  REDIS_URL = 'http://50.116.40.131'
else
  REDIS_URL = 'localhost'
end

REDIS = Redis.new(:host => REDIS_URL, :port => 6379)

PASSWORD_REQUIRED = ['production', 'staging']

if PASSWORD_REQUIRED.include? Rails.env
  require "#{Rails.root}/config/secret/redis_password.rb"
  REDIS.auth(REDIS_PASSWORD)
end