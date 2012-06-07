class Guest < ActiveRecord::Base
  attr_accessible :name, :email
  has_many :rooms

  before_create :set_name

  def set_name
    self.name = "Guest #{rand(1000)}"
  end

  def self.find_or_create_by_cookie(cookie)
    if cookie
      params = JSON.parse(cookie)
      Guest.where(id: params["id"].to_s).first
    else
      guest = Guest.create
    end
  end

  def user_hash
    { user_id: id.to_s, user_type: 'Guest', user_name: name }
  end

  def user_json
    user_hash.to_json
  end
end
