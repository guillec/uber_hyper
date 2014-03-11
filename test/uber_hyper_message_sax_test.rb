require 'test_helper'
require 'uber_hyper'
require 'pp'

describe " The UberHyper::Message " do

  describe " The uber message will have a root variable " do
    let(:uber_msg) { "<uber version='1.0'><data></data></uber>" }

    it " will respond_to root " do
      msg = UberHyper::Message.new
      sax = Nokogiri::XML::SAX::Parser.new(msg)
      sax.parse(uber_msg)

      assert msg.respond_to?(:root)
    end
  end

  describe " The root variable name will be uber " do
    let(:uber_msg) { "<uber version='1.0'><data></data></uber>" }

    it " will respond_to root " do
      msg = UberHyper::Message.new
      sax = Nokogiri::XML::SAX::Parser.new(msg)
      sax.parse(uber_msg)

      assert_equal msg.root[:name], "uber"
    end
  end

  describe " The root variable will have attributes " do
    let(:uber_msg) { "<uber version='1.0'><data></data></uber>" }

    it " will respond_to root " do
      msg = UberHyper::Message.new
      sax = Nokogiri::XML::SAX::Parser.new(msg)
      sax.parse(uber_msg)

      assert msg.root.has_key?(:attributes)
    end
  end

  describe " The root variable will have children " do
    let(:uber_msg) { "<uber version='1.0'><data></data></uber>" }

    it " will respond_to root " do
      msg = UberHyper::Message.new
      sax = Nokogiri::XML::SAX::Parser.new(msg)
      sax.parse(uber_msg)

      assert msg.root.has_key?(:children)
    end
  end

end
