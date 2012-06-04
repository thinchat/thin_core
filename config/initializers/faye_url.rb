if Rails.env == 'production'
  FAYE_URL = 'http://thinchat.com:9292'
else
  FAYE_URL = 'http://localhost:9292'
end
