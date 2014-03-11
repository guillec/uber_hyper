require "uber_hyper/version"
require "nokogiri"

module UberHyper 
  class Message < Nokogiri::XML::SAX::Document
    attr_reader :root

    def initialize
      super
      @element = {}
      @root    = @element
    end

    def start_element name, attrs = []
      if name == "uber"
        @element[:name] = name
        set_attributes(attrs)
      else
        element = { name: name, parent: @element }
        @element[:children]   ||= []
        @element[:children] << element
        @element = element
      end
    end

    def end_element name
      @element = @element[:parent]
    end

    def characters chars
      @element[:content] ||= ""
      @element[:content] << chars
    end

    def set_attributes(attrs)
      @element[:attributes] ||= {}
      attrs.map do |at|
        att = Hash[*at.each_slice(2).map{ |p| [p, p] }.flatten]
        @element[:attributes] = att
      end
    end
  end
end
