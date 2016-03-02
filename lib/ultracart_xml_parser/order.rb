require 'nokogiri'

module UltraCartXMLParser
  class Order
    FIELDS = {
      merchant_id: :string,
      order_id: :string,
      channel_partner_code: :string,
      channel_partner_order_id: :string,
      order_date: :datetime,
      order_type: :string,
      current_stage: :string,
      payment_status: :string,
      payment_date: :date,
      payment_date_time: :datetime,
      shipping_date: :date,
      shipping_date_time: :datetime,
      tax_county: :string,
      shipping_method: :string,
      lift_gate: :boolean,
      shipping_tracking_number: :string,
      gift: :boolean,
      email: :string,
      mailing_list: :boolean,
      day_phone: :string,
      evening_phone: :string,
      fax: :string,
      card_type: :string,
      card_number: :string,
      card_exp_month: :string,
      card_exp_year: :string,
      card_auth_ticket: :string,
      payment_method: :string,
      weight: :string,
      subtotal: :float,
      tax_rate: :float,
      tax: :float,
      shipping_handling_total: :float,
      shipping_handling_total_discount: :float,
      surcharge_transaction_fee: :float,
      surcharge_transaction_percentage: :float,
      surcharge: :float,
      total: :float,
      currency_code: :string,
      actual_profit_analyzed: :boolean,
      actual_profit_review: :boolean,
      actual_shipping: :float,
      actual_other_cost: :float,
      actual_fulfillment: :float,
      actual_payment_processing: :float,
      actual_profit: :float,
      gift_certificate_oid: :fixnum,
      gift_certificate_amount: :float,
      gift_certificate_code: :string,
      special_instructions: :string,
      merchant_notes: :string,
      subtotal_discount: :float,
      gift_charge_accounting_code: :string,
      gift_wrap_accounting_code: :string,
      surcharge_accounting_code: :string,
      shipping_method_accounting_code: :string,
      payment_method_accounting_code: :string,
      payment_method_deposit_to_account: :string,
      tax_country_accounting_code: :string,
      tax_state_accounting_code: :string,
      tax_county_accounting_code: :string,
      tax_city_accounting_code: :string,
      tax_postal_code_accounting_code: :string,
      referral_code: :string,
      advertising_source: :string,
      screen_branding_theme_code: :string,
      insureship_available: :boolean,
      insureship_separate: :boolean,
      insureship_wanted: :boolean,
      has_customer_profile: :boolean,
      customer_ip_address: :string
    }

    include FieldMapper

    def initialize(order)
      @element = order
    end

    def ship_to_address
      address_nodes = @element.xpath('./*[starts-with(name(), "ship_to")]')
      Address.new(@element, 'ship_to') unless address_nodes.empty?
    end

    def bill_to_address
      Address.new(@element, 'bill_to')
    end

    def items
      @element.xpath('./item').map { |item| Item.new(item) }
    end

    def coupons
      @element.xpath('./coupon').map { |coupon| Coupon.new(coupon) }
    end

    def customer_profile
      customer_profile = @element.xpath('./customer_profile')
      CustomerProfile.new(customer_profile) unless customer_profile.empty?
    end

    def transaction_details
      @element.xpath('./transaction_details/transaction_detail').map { |transaction_detail| TransactionDetail.new(transaction_detail) }
    end
  end
end
