require 'spec_helper'

describe Guest do
  context "given valid attributes" do
    it "does not raise an error" do
      expect{ Guest.new(name: "Test User", email: "test@test.com") }.to_not raise_error
    end
  end

  context "before create" do
    it "should set a random name" do
      Guest.create().name.blank?.should be_false
    end
  end

  it "returns the email on guest_email" do
    guest = Guest.new(name: "Test User", email: "test@test.com")
    guest.guest_email.class.should == String
  end

  describe ".find_or_create_by_cookie(cookie)" do
    let(:temp_guest) { double }
    let(:cookie) { '{ "id":"3" }' }

    it "tries to find the guest by id" do
      Guest.should_receive(:where).with({:id=>"3"}).and_return([temp_guest])
      guest = Guest.find_or_create_by_cookie(cookie)
      guest.should == temp_guest
    end

    context "given there is no guest" do
      it "creates a new guest" do
        Guest.should_receive(:create).and_return(temp_guest)
        guest = Guest.find_or_create_by_cookie(cookie)
        guest.should == temp_guest
      end
    end

    context "given cookie is nil" do
      it "creates a new guest" do
        cookie = nil
        Guest.should_receive(:create).and_return(temp_guest)
        guest = Guest.find_or_create_by_cookie(cookie)
        guest.should == temp_guest
      end
    end
  end

  describe "user_hash" do
    it "returns a hash with the agent attributes" do
      guest = Guest.new(name: "Test User")
      guest.should_receive(:id).and_return(1)
      hash = guest.user_hash
      hash.should be_a_kind_of(Hash)
      hash[:user_id].should == "1"
      hash[:user_type].should == "Guest"
      hash[:user_name].should == "Test User"
    end
  end

end
