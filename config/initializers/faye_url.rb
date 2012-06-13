if Rails.env == 'development'
  FAYE_URL = 'http://localhost:9292'
elsif Rails.env == 'staging'
  FAYE_URL = 'http://50.116.40.131:9292'
elsif Rails.env == 'production'
  FAYE_URL = 'http://thinchat.com:9292'
else
  raise NotImplementedError, "The environment '#{Rails.env}' has no FAYE_URL\n Set one in config/initializers/faye_url.rb"
end
