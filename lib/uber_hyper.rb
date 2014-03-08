require "uber_hyper/version"
require "nokogiri"

module UberHyper
  MissingRootError = Class.new(StandardError)
  MissingDataError = Class.new(StandardError)

  class Message

    class Error
      def initialize(error="")
        @error = error
      end

      def data
        @error.children.search("data").first
      end
    end

    def initialize(message="<uber></uber>")
      @msg = Nokogiri::XML::Document.parse(message)
      raise MissingRootError unless valid_root?
      raise MissingDataError unless valid_data?
      raise MissingDataError unless valid_error?
    end

    def version
      "1.0"
    end

    def error
      error_node = @msg.root.children.search("error").first
      return nil if error_node.nil?
      return Error.new(error_node)
    end

    def valid_root? 
      return false if @msg.root.nil? || @msg.root.name != "uber"
      return true
    end

    def valid_data? 
      return true if data_exist? && ( uber_parent? || error_parent? )
      return false
    end

    def valid_error?
      return true if error.nil?
      return false if error.data.nil?
      return true
    end

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
