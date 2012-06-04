class Guest < ActiveRecord::Base
  attr_accessible :name, :email

  before_save :init

  def init
    self.name = "Guest #{rand(1000)}"
  end

end
