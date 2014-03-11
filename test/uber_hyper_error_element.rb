require "test_helper"
require "uber_hyper"

describe "UberHyper::Message::ErrorElement" do
  describe "data" do
    let(:uber_message) { "<uber version='1.0'><error><data></data><data></data></error></uber>" }

    it "can return an array of data" do
      message = UberHyper::Message.new(uber_message)

      assert_equal message.data.count, 2
      assert_instance_of Array, message.data
    end
  end
end
