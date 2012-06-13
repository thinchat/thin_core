class Guest < ActiveRecord::Base
  attr_accessible :name, :email
  validates_presence_of :name
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :format => { :with => email_regex },
                    :allow_blank => true
  has_many :rooms

  before_create :set_name

  def set_name
    self.name = "Guest #{rand(1000)}"
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
end
