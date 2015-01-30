module UltraCartXMLParser
  class Address
    FIELDS = [:title, :company, :first_name, :last_name, :address1, :address2, :city, :state, :zip, :country]

    def initialize(element)
      @address = element
    end

    FIELDS.each do |field|
      define_method(field) do
        # Nokogiri doesn't support XPath 2.0 so the 'ends-with' function is not available
        result = @address.at_xpath("//*[substring(name(),string-length(name())-#{field.length - 1}) = '#{field}']").text
        result == "" ? nil : result
      end
    end
  end
end
