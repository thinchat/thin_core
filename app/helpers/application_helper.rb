module ApplicationHelper
  def faye_url
    if Rails.env == 'production'
      'http://thinchat.com:9292'
    else
      'http://localhost:9292'
    end
  end
end
