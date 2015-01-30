require "ultracart_xml_parser/version"

require "ultracart_xml_parser/order"
require "ultracart_xml_parser/address"
require "ultracart_xml_parser/coupon"

module UltraCartXMLParser
  FIELDS = {}

  def coerce_float(e)
    e.text.to_f
  end

  def coerce_string(e)
    e.text
  end

  def coerce_date(e)
    Date.strptime(e, '%m/%d/%Y')
  end

  def coerce_time(e)
    Time.strptime(e, '')
  end

  FIELDS.each do |field, type|
    define_method(field) { self.send('coerce_' + type, @element.at(field)) }
  end
end
