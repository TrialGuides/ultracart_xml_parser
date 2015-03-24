require 'date'

module UltraCartXMLParser
  module FieldMapper
    def coerce(element)
      return nil if element.nil? || (text = element.text).blank?

      yield(text)
    end

    def coerce_boolean(element)
      coerce(element) { |text| text[0].downcase == 'y' || text[0].downcase == 't' }
    end

    def coerce_fixnum(element)
      coerce(element) { |text| text.to_i }
    end

    def coerce_float(element)
      coerce(element) { |text| text.to_f }
    end

    def coerce_string(element)
      coerce(element) { |text| text }
    end

    def coerce_date(element)
      coerce(element) { |text| Date.strptime(text, '%m/%d/%Y') }
    end

    def coerce_datetime(element)
      coerce(element) { |text| DateTime.parse(text) }
    end

    def self.included(other)
      other::FIELDS.each do |field, type|
        define_method(field) { self.send('coerce_' + type.to_s, @element.at(field)) }
        alias_method field.to_s + '?', field if type == :boolean
      end
    end
  end
end
