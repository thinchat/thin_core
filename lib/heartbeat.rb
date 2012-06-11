module ThinHeartbeat
  class Status
    attr_accessor :redis

    def initialize(password = nil)
      @redis = Redis.new(:host => 'localhost', :port => 6379)
      @redis.auth(password) if password
    end

    def get_users
      keys = redis.keys "hb:*"
      users = keys.collect do |key|
        json_to_hashie(redis.smembers(key).first)
      end

      # [#<Hashie::Mash client_id="6v42flzhf6rn1vq4fg0vwfcjv" room="/messages/6" room_id="6" user_id="2" user_name="Edward Weng" user_type="Agent">]
    end

    def json_to_hashie(json)
      Hashie::Mash.new(JSON.parse(json))
    end
  end
end