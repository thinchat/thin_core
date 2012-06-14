require "spec_helper"

describe LogMailer do
  describe "log_transcript" do
    let(:mail) { LogMailer.log_transcript }

    it "renders the headers" do
      mail.subject.should eq("Log transcript")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
