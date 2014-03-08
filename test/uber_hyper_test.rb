require 'test_helper'
require 'uber_hyper'

describe "Section 3.6: The <uber> Element" do

  describe "Every Uber message MUST have this as it’s root" do
    let(:uber_msg) { "<uber><data></data></uber>" }
    let(:non_uber_msg) { '<body></body>' }

    it "will return true if it has a <uber> has root" do
      valid_message  = UberHyper::Message.new(uber_msg)
      assert_equal valid_message.valid_root?, true
    end

    it "will raise MissingRootError if it doesn't a <uber> as root" do
      assert_raises(UberHyper::MissingRootError) do 
        UberHyper::Message.new(non_uber_msg)
      end
    end
  end

  describe "The <uber> element has one optional attribute: 'version' which should be set to 1.0 for this version" do
    let(:uber_msg) { "<uber version='1.0'><data></data></uber>" }
    let(:missing_version) { "<uber><data></data></uber>" }

    it "should be set to '1.0'"do
      valid_message  = UberHyper::Message.new(uber_msg)
      assert_equal valid_message.version, "1.0"
    end

    it "should be set to '1.0' even if version attribute is missing"do
      missing_ver  = UberHyper::Message.new(missing_version)
      assert_equal missing_ver.version, "1.0"
    end
  end


end

describe "Section 3.7 The <data> Element" do

  describe "A valid Uber message SHOULD contain at least one <data> element" do
    let(:uber_msg) { "<uber version='1.0'><data></data></uber>" }
    let(:nested_msg) { "<uber version='1.0'><data><data></data></data></uber>" }
    let(:data_in_error) { "<uber version='1.0'><error><data></data></error></uber>" }
    let(:missing_data) { "<uber></uber>" }
    
    it "will return true if it contains a data element" do
      message = UberHyper::Message.new(uber_msg)
      assert_equal message.valid_data?, true
    end

    it "the <data> element appears as a child of the <uber> or <error> elements" do
      message = UberHyper::Message.new(data_in_error)
      assert_equal message.valid_data?, true
    end

    it "MAY be nested as many times as needed" do
      message = UberHyper::Message.new(nested_msg)
      assert_equal message.valid_data?, true
    end

    it "will raise MissingDataError if it doesnt contains a data element" do
      assert_raises(UberHyper::MissingDataError) do
        UberHyper::Message.new(missing_data)
      end
    end
  end

  describe "<data> element attributes" do
    #TODO
  end
end

