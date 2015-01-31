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

    def items
      @element.xpath('//export/order/item').map { |item| Item.new(item) }
    end

    def coupons
      @element.xpath('//export/order/coupon').map { |coupon| Coupon.new(coupon) }
    end

    def transaction_details
      puts "********** #{@element.xpath('//export/order/transaction_details/transaction_detail').count}"
      @element.xpath('//export/order/transaction_details/transaction_detail').map { |transaction_detail| TransactionDetail.new(transaction_detail) }
    end
  end
end
