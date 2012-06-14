class Room < ActiveRecord::Base
  attr_accessible :name, :status
  validates_presence_of :name
  has_one :guest
  
  has_many :messages

  def channel
    "/messages/#{id}"
  end

end