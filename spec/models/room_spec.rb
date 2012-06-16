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
  end
end