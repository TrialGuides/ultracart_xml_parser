require "ultracart_xml_parser/version"

require "ultracart_xml_parser/field_mapper"

require "ultracart_xml_parser/order"
require "ultracart_xml_parser/item"
require "ultracart_xml_parser/address"
require "ultracart_xml_parser/coupon"
require "ultracart_xml_parser/extended_detail"
require "ultracart_xml_parser/transaction_detail"

module UltraCartXMLParser
  def self.parse(io)
    document = Nokogiri::XML::Reader(io) do |config|
      config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
    end
    orders = []
    document.each do |node|
      if node.name == 'order' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        orders << Order.new(Nokogiri::XML(node.outer_xml).at('./order'))
      end
    end
    orders
  end
end
