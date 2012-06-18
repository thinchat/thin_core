class Room < ActiveRecord::Base
  attr_accessible :name, :status, :guest_id
  attr_accessor :users
  has_many :messages
  before_create :set_name
  belongs_to :guest
  scope :oldest_first, order("created_at ASC")

  STATUSES = ["Pending", "Active", "Closed"]

  STATUSES.each do |selected_status|
    define_singleton_method "#{selected_status.downcase}".to_sym do
      Room.where{status.matches selected_status}.oldest_first
    end
  end

  def self.close_empty_rooms
    all_users = ThinHeartbeat::Status.new($redis).get_users
    true
  end

  def pretty_time
    if created_at
      created_at.strftime("%l:%M %p")
    else
      Time.now.strftime("%l:%M %p")
    end
  end

  def set_name
    self.name = rand(36**8).to_s(16)
  end

  ["pending", "active", "closed"].each do |room_status|
    define_method "#{room_status}?".to_sym do
      status == room_status.capitalize
    end
  end

  def open?
    !closed?
  end

  def channel
    "/messages/#{name}"
  end

  def change_to_active
    self.update_attribute(:status, "Active") if status == "Pending"
  end
end