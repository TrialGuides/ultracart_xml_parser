require 'nokogiri'

module UltraCartXMLParser
  class Order
    def Order.parse(xml_string)
      self.new(Nokogiri::XML::Document.parse(xml_string))
    end

    def initialize(document)
      @element = document
    end

    def ship_to_address
      Address.new(@element.xpath('//export/order/*[starts-with(name(), "ship_to")]'))
    end

    def bill_to_address
      Address.new(@element.xpath('//export/order/*[starts-with(name(), "bill_to")]'))
    end
  end
end
