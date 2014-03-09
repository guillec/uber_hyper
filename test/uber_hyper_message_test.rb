require "test_helper"
require "uber_hyper"

describe "UberHyper::Message" do
  describe "error" do
    let(:uber_message) { "<uber version='1.0'><error><data></data></error></uber>" }
    let(:no_error) { "<uber version='1.0'><data></data></uber>" }

    it "can returns a error" do
      message = UberHyper::Message.new(uber_message)
      assert_instance_of UberHyper::Message::Error, message.error
    end

    it "returns nil if no error element" do
      message = UberHyper::Message.new(no_error)
      assert_equal message.error, nil
    end
  end

  describe "data" do
    let(:uber_message) { "<uber version='1.0'><data></data></uber>" }

    it "can return a error" do
      message = UberHyper::Message.new(uber_message)
      assert_instance_of UberHyper::Message::Data, message.data
    end
  end
end
