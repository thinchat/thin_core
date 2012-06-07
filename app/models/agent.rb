class Agent < ActiveRecord::Base
  attr_accessible :name, :thin_auth_id

  def self.new_from_cookie(cookie)
    params = JSON.parse(cookies.signed[:user])
    Agent.new(thin_auth_id: params["id"], name: params["name"])
  end

  def user_hash
    { user_id: thin_auth_id, user_type: 'Agent', user_name: name }
  end
end
