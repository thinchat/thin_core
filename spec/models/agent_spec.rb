require 'spec_helper'

describe Agent do
  context "given valid attributes" do
    it "does not raise an error" do
      expect{ Agent.new(3, "Test User") }.to_not raise_error
    end
  end

  context "when trying to create" do
    it "should throw an undefined method error" do
      expect{ Agent.create(3, "Test User") }.to raise_error(NoMethodError)
    end
  end

  describe ".new_from_cookie(cookie)" do
    it "creates a new Agent" do
      cookie = '{ "id":"3", "name":"Test User" }'
      agent = Agent.new_from_cookie(cookie)
      agent.thin_auth_id.should == 3
      agent.name.should == "Test User"
    end
  end

  describe "user_hash" do
    it "returns a hash with the agent attributes" do
      Agent.new(3, "Test User").user_hash.should be_a_kind_of(Hash)
    end
  end
end
