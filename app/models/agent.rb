class Agent
  # attr_accessible :name, :thin_auth_id
  attr_accessor :name, :thin_auth_id

  def id
    thin_auth_id
  end

  def initialize(thin_auth_id, name)
    @thin_auth_id = thin_auth_id.to_i
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

  def self.find_by_authentication_token(token)
    uri = URI.parse("#{root_url}/auth/api/v1/users.json?authentication_token=#{thin_auth_id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)["authentication_token"]
  end
end
