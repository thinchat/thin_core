class Room < ActiveRecord::Base
  attr_accessible :name, :status
  has_many :messages
  before_create :set_name

  def set_name
    self.name = rand(36**8).to_s(16)
  end

  def closed?
    status == "Closed"
  end

  def self.in_queue
    statuses = [ "Pending", "Active" ]
    Room.where{status.in statuses}
  end

  def channel
    "/messages/#{name}"
  end
end