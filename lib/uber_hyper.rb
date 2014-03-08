require "uber_hyper/version"
require "nokogiri"

module UberHyper
  MissingRootError = Class.new(StandardError)
  MissingDataError = Class.new(StandardError)

  class Message
    def initialize(message="<uber></uber>")
      @msg = Nokogiri::XML::Document.parse(message)
      raise MissingRootError unless valid_root?
      raise MissingDataError unless valid_data?
    end

    def valid_root? 
      return false if @msg.root.nil? || @msg.root.name != "uber"
      return true
    end

    def valid_data? 
      return true if data_exist? && ( uber_parent? || error_parent? )
      return false
    end

    def version
      "1.0"
    end

    private
    def data_exist?
      @msg.root.children.search("data").count > 0
    end

    def uber_parent?
      data_node = @msg.root.children.search("data").first
      data_node.parent.name == "uber"
    end

    def error_parent?
      data_node = @msg.root.children.search("data").first
      data_node.parent.name == "error"
    end
  end
end
