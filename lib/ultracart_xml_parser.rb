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
    document = Nokogiri::XML(io) do |config|
      config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
    end
    document.xpath('/export/order').map do |order|
      Order.new(order)
    end
  end
end
