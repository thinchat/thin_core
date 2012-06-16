require 'spec_helper'

describe Message do
  context "a message with valid attributes" do
    let(:message) { Message.new(body: "a" * 1000, room_id: 1) }

    it "is valid" do
      message.should be_valid
    end

    it "cannot have more than 1000 characters" do
      message.body = "a" * 1001
      message.should_not be_valid
    end

    it "cannot have a blank room_id" do
      message.room_id = nil
      message.should_not be_valid
    end
  end

  describe "#to_hash" do
    let(:message) { Message.new(room_id: 1) }
    it "should return a hash" do
      hash = message.to_hash
      hash.should be_a_kind_of(Hash)
      [:room_id, :user_name, :user_id, :user_type, :message_id, 
       :message_type, :message_body, :metadata, :created_at].each do |key|
        hash.has_key?(key).should be_true
      end
    end
  end

  describe "#broadcast" do
    let(:message) { Message.new() }

    it "should attempt to publish to faye and redis" do
      message.should_receive(:publish_to_faye).and_return(true)
      message.should_receive(:publish_to_redis).and_return(true)
      message.broadcast
    end
  end

  describe "#in_room?" do
    let(:message) { Message.new(:room_id => 1) }

    context "Given a message is created in a room" do
      it "should return true" do
        message.in_room?.should == true
      end
    end

    context "Given a message is created outside a room" do
      it "should return false" do
        message.room_id = 0
        message.in_room?.should == false
      end
    end
  end

  describe "#from_agent?" do
    let(:guest_message) { Message.new(:user_type => "Guest") }
    let(:agent_message) { Message.new(:user_type => "Agent") }

    context "Given a message is created by an agent" do
      it "should return true" do
        agent_message.from_agent?.should == true
      end
    end

    context "Given a message is created by a guest" do
      it "should return false" do
        guest_message.from_agent?.should == false
      end
    end
  end

  describe "#from_guest?" do
    let(:guest_message) { Message.new(:user_type => "Guest") }
    let(:agent_message) { Message.new(:user_type => "Agent") }

    context "Given a message is created by a guest" do
      it "should return true" do
        guest_message.from_guest?.should == true
      end
    end

    context "Given a message is created by an agent" do
      it "should return false" do
        agent_message.from_guest?.should == false
      end
    end
  end
end