if Rails.env == 'production'
  FAYE_URL = 'http://thinchat.com:9292'
elsif Rails.env == 'staging'
  FAYE_URL = 'http://50.116.40.131:9292'
else
  FAYE_URL = 'http://localhost:9292'
end