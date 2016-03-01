require 'carmen'

module UltraCartXMLParser
  class Address
    FIELDS = [:title, :company, :first_name, :last_name, :address1, :address2, :city, :state, :zip, :country]

    def initialize(order, prefix)
      @order = order
      @prefix = prefix
    end

    FIELDS.each do |field|
      define_method(field) do
        result = @order.xpath("//#{@prefix}_#{field}").text
        result == "" ? nil : result
      end
    end

    def country_code
      @country_code ||= Carmen::Country.named(country).alpha_2_code
    end
  end
end
