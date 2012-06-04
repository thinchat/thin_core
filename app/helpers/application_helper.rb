module ApplicationHelper
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("#{faye_url}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def faye_url
    if Rails.env == 'production'
      'http://thinchat.com:9292'
    else
      'http://localhost:9292'
    end
  end
end
