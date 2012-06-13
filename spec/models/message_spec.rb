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

  describe "#channel" do
    let(:message) { Message.new(room_id: 1) }
    it "returns the channel it is associated" do
      message.channel == "/messages/1"
    end
  end

  describe "#broadcast" do
    let(:message) { Message.new() }

    it "should publish to faye and redis" do
      message.should_receive(:publish_to_faye)
      message.should_receive(:publish_to_redis)
      message.broadcast
    end
  end

  describe "#faye_message" do
    let(:message) { Message.new(:room_id => 123) }

    it "should return a hash of message data" do
      faye_message = message.faye_message
      faye_message[:channel].should == "/messages/123"
      faye_message[:data][:chat_message].should have_key(:message_body)
    end
  end
end