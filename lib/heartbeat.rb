module ThinHeartbeat
  class Status
    REDIS = Redis.new(:host => 'localhost', :port => 6379)

    def self.get_users
      keys = REDIS.keys "hb:*"
      users = keys.collect do |key|
        json_to_hashie(REDIS.smembers(key).first)
      end
    end

    def self.json_to_hashie(json)
      Hashie::Mash.new(JSON.parse(json))
    end
  end
end