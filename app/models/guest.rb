class Guest < ActiveRecord::Base
  attr_accessible :name, :email
  has_many :rooms

  before_create :set_name, :set_auth_token
  
  def set_name
    self.name = "Guest #{rand(1000)}"
  end

  def set_auth_token
    self.authentication_token = rand(36**8).to_s(16)
  end

  def self.find_or_create_by_cookie(cookie)
    params = cookie ? JSON.parse(cookie) : nil
    if params && guest = Guest.where(id: params["id"].to_s).first
      guest
    else
      Guest.create
    end
  end

  def user_hash
    { user_id: id.to_s, user_type: 'Guest', user_name: name }
  end

  def guest_email
    email ? email : ""
  end

  ["guest", "agent"].each do |user_type|
    define_method "#{user_type}?".to_sym do
      self.class.to_s.downcase == user_type
    end
  end
end
