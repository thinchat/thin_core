require 'heartbeat.rb'

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

  def self.open_rooms
    Room.pending + Room.active
  end

  def self.build_for_user(user)
    user.agent? ? Room.new : user.rooms.build
  end

  def self.find_by_name_for_user(user, name)
    if user.guest?
      user.rooms.find_by_name(name)
    else
      Room.find_by_name(name)
    end
  end

  def self.get_rooms_and_close_empty
    rooms_with_users = ThinHeartbeat::Status.new($redis).get_rooms_with_users
    Room.open_rooms.each do |room|
      unless rooms_with_users.include? room.name
        room.update_attribute(:status, "Closed")
        open_rooms.delete(room.name)
      end
    end
    open_rooms
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