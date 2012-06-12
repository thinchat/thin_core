class Agent
  # attr_accessible :name, :thin_auth_id
  attr_accessor :name, :thin_auth_id

  def initialize(thin_auth_id, name)
    @thin_auth_id = thin_auth_id
    @name = name
  end

  def self.new_from_cookie(cookie)
    params = JSON.parse(cookie)
    Agent.new(params["id"], params["name"])
  end

  def user_hash(location = nil)
    hash = { user_id: thin_auth_id.to_s, user_type: 'Agent', user_name: name}
    location ? hash[:room_id] = location : hash
  end
end
