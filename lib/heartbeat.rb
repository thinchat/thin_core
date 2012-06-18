module ThinHeartbeat
  class Status
    attr_accessor :redis

    def initialize(redis_client)
      @redis = redis_client
    end

    def get_users
      keys = redis.keys "hb:*"
      get_hashies_from_keys(keys)
    end

    def get_agents
      keys = redis.keys "hb:*Agent:*"
      get_hashies_from_keys(keys)
    end

    def get_guests
      keys = redis.keys "hb:*Guest:*"
      get_hashies_from_keys(keys)      
    end

    def get_users_in_room(room_name)
      keys = redis.keys "hb:*#{room_name}*"
      get_hashies_from_keys(keys)
    end

    def get_rooms_for_user(user)
      keys = redis.keys "hb:*#{user.user_type}:#{user.user_id}*"
      get_hashies_from_keys(keys)
    end

    def get_hashies_from_keys(keys)
      keys.collect do |key|
        json_to_hashie(redis.smembers(key).first)
      end
    end

    def json_to_hashie(json)
      Hashie::Mash.new(JSON.parse(json))
    end
  end
end