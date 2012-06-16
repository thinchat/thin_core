require "spec_helper"

describe LogMailer do
  describe "log_transcript" do
    let(:mail) { LogMailer.log_transcript("test@test.com", 1) }
    let(:room) { Room.new }

    it "renders the headers" do
      Room.should_receive(:find).with(1).and_return(room)
      room.created_at.should_receive(:to_date).and_return("")
      mail.subject.should eq("Your Chat Transcript from Thinchat")
      mail.to.should eq(["test@test.com"])
      mail.from.should eq(["thinchat@gmail.com"])
    end

    it "renders the body" do
      Room.should_receive(:find).with(1).and_return(room)
      room.created_at.should_receive(:to_date).and_return("")
      mail.body.encoded.should_not be_nil
    end
  end

end
