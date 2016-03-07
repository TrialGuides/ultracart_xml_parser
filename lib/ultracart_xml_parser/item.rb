module UltraCartXMLParser
  class Item
    FIELDS = { 
      merchant_id: :string, 
      order_id: :string, 
      item_id: :string, 
      item_index: :fixnum, 
      quantity: :fixnum, 
      description: :string, 
      cost: :float, 
      unit_cost_with_discount: :float, 
      total_cost_with_discount: :float, 
      cogs: :float, actual_cogs: :float, 
      barcode: :string, 
      manufacturer_sku: :string, 
      country_of_origin: :string, 
      item_weight: :string, 
      tax_free: :boolean, 
      special_product_type: :string, 
      free_shipping: :boolean, 
      accounting_code: :string, 
      discount: :float, 
      distribution_center_code: :string, 
      kit: :boolean, 
      kit_component: :boolean,
      quantity_refunded: :float,
      total_refunded: :float
    }

    include FieldMapper

    def initialize(item)
      @element = item
    end
  end
end
