require 'date'

module UltraCartXMLParser
  module FieldMapper
    def coerce_boolean(e)
      return nil unless e

      text = e.text.downcase
      text == "" ? nil : text[0] == 'y' || text[0] == 't'
    end

    def coerce_fixnum(e)
      return nil unless e

      text = e.text
      text == "" ? nil : text.to_i
    end

    def coerce_float(e)
      return nil unless e

      text = e.text
      text == "" ? nil : text.to_f
    end

    def coerce_string(e)
      return nil unless e

      text = e.text
      text == "" ? nil : text
    end

    def coerce_date(e)
      return nil unless e

      text = e.text
      text == "" ? nil : Date.strptime(text, '%m/%d/%Y')
    end

    def coerce_datetime(e)
      return nil unless e

      text = e.text
      text == "" ? nil : DateTime.parse(text)
    end

    def self.included(other)
      other::FIELDS.each do |field, type|
        define_method(field) { self.send('coerce_' + type.to_s, @element.at(field)) }
      end
    end
  end
end
