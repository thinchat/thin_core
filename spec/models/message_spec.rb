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

  describe "#agent?" do
    let(:message) { Message.new(thin_auth_id: 1) }

    context "if a message is published by an agent" do
      it "returns true" do
        message.agent?.should == true
      end
    end

    context "if a message is published by a guest" do
      it "returns false" do
        message.thin_auth_id = nil
        message.agent?.should == false
      end
    end
  end

  describe "#agent" do
    let(:message) { Message.new(thin_auth_id: 1) }

    context "if a message is published by an agent" do
      it "returns the agent" do
        raise message.inspect

        agent = double
        Agent.should_receive(:where).with({thin_auth_id: message.thin_auth_id.to_s}).and_return([agent])
        message.agent.should == agent
      end
    end

    context "if a message is published by a guest" do
      it "returns nil" do
        # message.thin_auth_id = nil
        message.agent.should == nil
      end
    end
  end
end