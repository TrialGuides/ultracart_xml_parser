module UltraCartXMLParser
  class Coupon
    FIELDS = { 
      merchant_id: :string, 
      order_id: :string, 
      coupon_code: :string, 
      base_coupon_code: :string, 
      coupon_accounting_code: :string
    }

    include FieldMapper

    def initialize(elements)
      @element = elements
    end
  end
end
