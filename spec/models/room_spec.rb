require 'spec_helper'

describe Room do
  context "a valid room" do
    it "has a name" do
      room = Room.new(name: "test")
      room.should be_valid
    end

    it "can be created without a name" do
      room = Room.new()
      room.should be_valid
    end

    it "has a channel" do
      room = Room.new(name: "test")
      room.channel.class.should == String
    end

    it "will be changed to active on change_to_active" do
      room = Room.new(status: "Active")
      room.change_to_active
      room.status.should == "Active"
    end

    it "will return true to 'open?' if room is open" do
      room = Room.new(status: "Active")
      room.open?.should == true
    end

    it "will return true to 'closed?' if room is closed" do
      room = Room.new(status: "Closed")
      room.closed?.should == true
    end
  end
end