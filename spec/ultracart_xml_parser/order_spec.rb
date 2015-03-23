require 'spec_helper'

describe UltraCartXMLParser::Order do
  # Attributes that don't change between states
  shared_examples 'it has the common attributes' do
    it 'returns a valid merchant_id' do
      expect(order.merchant_id).to eq('ABC')
    end

    it 'returns a valid order_id' do
      expect(order.order_id).to eq('ABC-12345')
    end

    it 'returns a valid order_date' do
      expect(order.order_date).to eq(DateTime.new(2015, 1, 1, 12, 0, 0))
    end

    it 'returns a valid order_type' do
      expect(order.order_type).to eq('credit card')
    end

    it 'returns a valid tax_county' do
      expect(order.tax_county).to be_nil
    end

    it 'returns a valid shipping_method' do
      expect(order.shipping_method).to eq('FedEx: Ground')
    end

    it 'returns a valid lift_gate' do
      expect(order.lift_gate).to be false
    end

    it 'returns a valid lift_gate?' do
      expect(order.lift_gate?).to be false
    end

    it 'returns a valid gift' do
      expect(order.gift).to be false
    end

    it 'returns a valid gift?' do
      expect(order.gift?).to be false
    end

    it 'returns a valid email' do
      expect(order.email).to eq('tester@example.com')
    end

    it 'returns a valid day_phone' do
      expect(order.day_phone).to eq('(503) 555-1212')
    end

    it 'returns a valid evening_phone' do
      expect(order.evening_phone).to eq('(503) 555-1212')
    end

    it 'returns a valid fax' do
      expect(order.fax).to be_nil
    end

    it 'returns a valid weight' do
      expect(order.weight).to eq('1 LB')
    end

    it 'returns a valid subtotal' do
      expect(order.subtotal).to eq(100.00)
    end

    it 'returns a valid tax_rate' do
      expect(order.tax_rate).to eq(0.00000)
    end

    it 'returns a valid tax' do
      expect(order.tax).to eq(0.00)
    end

    it 'returns a valid shipping_handling_total' do
      expect(order.shipping_handling_total).to eq(10.00)
    end

    it 'returns a valid shipping_handling_total_discount' do
      expect(order.shipping_handling_total_discount).to eq(0.00)
    end

    it 'returns a valid surcharge_transaction_fee' do
      expect(order.surcharge_transaction_fee).to eq(0.00)
    end

    it 'returns a valid surcharge_transaction_percentage' do
      expect(order.surcharge_transaction_percentage).to eq(0.0000)
    end

    it 'returns a valid surcharge' do
      expect(order.surcharge).to eq(0.00)
    end

    it 'returns a valid total' do
      expect(order.total).to eq(110.00)
    end

    it 'returns a valid currency_code' do
      expect(order.currency_code).to be_nil
    end

    it 'returns a valid actual_profit_analyzed' do
      expect(order.actual_profit_analyzed).to be false
    end

    it 'returns a valid actual_profit_analyzed?' do
      expect(order.actual_profit_analyzed?).to be false
    end

    it 'returns a valid actual_profit_review' do
      expect(order.actual_profit_review).to be false
    end

    it 'returns a valid actual_profit_review?' do
      expect(order.actual_profit_review?).to be false
    end

    it 'returns a valid actual_shipping' do
      expect(order.actual_shipping).to be_nil
    end

    it 'returns a valid actual_other_cost' do
      expect(order.actual_other_cost).to be_nil
    end

    it 'returns a valid actual_fulfillment' do
      expect(order.actual_fulfillment).to be_nil
    end

    it 'returns a valid actual_payment_processing' do
      expect(order.actual_payment_processing).to be_nil
    end

    it 'returns a valid actual_profit' do
      expect(order.actual_profit).to be_nil
    end

    it 'returns a valid gift_certificate_amount' do
      expect(order.gift_certificate_amount).to eq(0.00)
    end

    it 'returns a valid special_instructions' do
      expect(order.special_instructions).to be_nil
    end

    it 'returns a valid merchant_notes' do
      expect(order.merchant_notes).to be_nil
    end

    it 'returns a valid subtotal_discount' do
      expect(order.subtotal_discount).to eq(0.00)
    end

    it 'returns a valid gift_charge_accounting_code' do
      expect(order.gift_charge_accounting_code).to be_nil
    end

    it 'returns a valid gift_wrap_accounting_code' do
      expect(order.gift_wrap_accounting_code).to be_nil
    end

    it 'returns a valid surcharge_accounting_code' do
      expect(order.surcharge_accounting_code).to be_nil
    end

    it 'returns a valid shipping_method_accounting_code' do
      expect(order.shipping_method_accounting_code).to be_nil
    end

    it 'returns a valid payment_method_accounting_code' do
      expect(order.payment_method_accounting_code).to be_nil
    end

    it 'returns a valid payment_method_deposit_to_account' do
      expect(order.payment_method_deposit_to_account).to be_nil
    end

    it 'returns a valid tax_country_accounting_code' do
      expect(order.tax_country_accounting_code).to be_nil
    end

    it 'returns a valid tax_state_accounting_code' do
      expect(order.tax_state_accounting_code).to be_nil
    end

    it 'returns a valid tax_county_accounting_code' do
      expect(order.tax_county_accounting_code).to be_nil
    end

    it 'returns a valid tax_city_accounting_code' do
      expect(order.tax_city_accounting_code).to be_nil
    end

    it 'returns a valid tax_postal_code_accounting_code' do
      expect(order.tax_postal_code_accounting_code).to be_nil
    end

    it 'returns a valid referral_code' do
      expect(order.referral_code).to be_nil
    end

    it 'returns a valid advertising_source' do
      expect(order.advertising_source).to eq('Existing Customer')
    end

    it 'returns a valid screen_branding_theme_code' do
      expect(order.screen_branding_theme_code).to eq('THEME-X')
    end

    it 'returns a valid insureship_available' do
      expect(order.insureship_available).to eq(false)
    end

    it 'returns a valid insureship_available?' do
      expect(order.insureship_available?).to eq(false)
    end

    it 'returns a valid insureship_separate' do
      expect(order.insureship_separate).to eq(false)
    end

    it 'returns a valid insureship_separate?' do
      expect(order.insureship_separate?).to eq(false)
    end

    it 'returns a valid insureship_wanted' do
      expect(order.insureship_wanted).to eq(false)
    end

    it 'returns a valid insureship_wanted?' do
      expect(order.insureship_wanted?).to eq(false)
    end

    it 'returns a valid has_customer_profile' do
      expect(order.has_customer_profile).to eq(true)
    end

    it 'returns a valid has_customer_profile?' do
      expect(order.has_customer_profile?).to eq(true)
    end

    it 'returns a valid customer_ip_address' do
      expect(order.customer_ip_address).to eq('127.0.0.1')
    end
  end

  context 'when an order has a shipping address and a billing address' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('address')) }

    it 'should have a bill_to_address' do
      expect(order.bill_to_address).to be_an_instance_of(UltraCartXMLParser::Address)
    end

    it 'should have a ship_to_address' do
      expect(order.ship_to_address).to be_an_instance_of(UltraCartXMLParser::Address)
    end
  end

  shared_examples 'it includes payment data' do
    it 'returns a valid card_type' do
      expect(order.card_type).to eq('MasterCard')
    end

    it 'returns a valid card_number' do
      expect(order.card_number).to eq('1234')
    end

    it 'returns a valid card_exp_month' do
      expect(order.card_exp_month).to eq('10')
    end

    it 'returns a valid card_exp_year' do
      expect(order.card_exp_year).to eq('2020')
    end

    it 'returns a valid card_auth_ticket' do
      expect(order.card_auth_ticket).to be_nil
    end

    it 'returns a valid payment_method' do
      expect(order.payment_method).to eq('Credit Card')
    end
  end

  shared_examples 'it does not include payment processing data' do
    it 'returns a valid payment_date' do
      expect(order.payment_date).to be_nil
    end

    it 'returns a valid payment_date_time' do
      expect(order.payment_date_time).to be_nil
    end
  end

  shared_examples 'it includes payment processing data' do
    it 'returns a valid payment_date' do
      expect(order.payment_date).to eq(Date.new(2015, 1, 1))
    end

    it 'returns a valid payment_date_time' do
      expect(order.payment_date_time).to eq(DateTime.new(2015, 1, 1, 14, 00, 00))
    end
  end

  shared_examples 'it does not include shipping data' do
    it 'returns a valid shipping_date' do
      expect(order.shipping_date).to be_nil
    end

    it 'returns a valid shipping_date_time' do
      expect(order.shipping_date_time).to be_nil
    end

    it 'returns a valid shipping_tracking_number' do
      expect(order.shipping_tracking_number).to be_nil
    end
  end

  shared_examples 'it includes shipping data' do
    it 'returns a valid shipping_date' do
      expect(order.shipping_date).to eq(Date.new(2015, 1, 1))
    end

    it 'returns a valid shipping_date_time' do
      expect(order.shipping_date_time).to eq(DateTime.new(2015, 1, 1, 14, 30, 00))
    end

    it 'returns a valid shipping_tracking_number' do
      expect(order.shipping_tracking_number).to eq('123456789012345')
    end
  end

  shared_examples 'customer subscribed to mailing list' do
    it 'returns a valid mailing_list' do
      expect(order.mailing_list).to eq(true)
    end

    it 'returns a valid mailing_list?' do
      expect(order.mailing_list?).to eq(true)
    end
  end

  shared_examples 'customer did not subscribe to mailing list' do
    it 'returns a valid mailing_list' do
      expect(order.mailing_list).to eq(false)
    end

    it 'returns a valid mailing_list?' do
      expect(order.mailing_list?).to eq(false)
    end
  end

  context 'when an order only has a billing address' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('address_no_shipping')) }

    it 'should have a bill_to_address' do
      expect(order.bill_to_address).to be_an_instance_of(UltraCartXMLParser::Address)
    end

    it 'should have a ship_to_address' do
      expect(order.ship_to_address).to be_nil
    end
  end

  context 'when an order has coupons' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('coupons')) }

    it 'should have a coupon' do
      expect(order.coupons).not_to be_empty
    end

    it 'should have the correct type of coupons' do
      expect(order.coupons.first).to be_an_instance_of(UltraCartXMLParser::Coupon)
    end
  end

  context 'when an order does not have coupons' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('no_coupons')) }

    it 'should have no coupons' do
      expect(order.coupons).to be_empty
    end
  end

  context 'when an order has items' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('items')) }

    it 'should have items' do
      expect(order.items).not_to be_empty
    end

    it 'should have the correct type of items' do
      expect(order.items.first).to be_an_instance_of(UltraCartXMLParser::Item)
    end
  end

  context 'when an order has no items' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('no_items')) }

    it 'should have no items' do
      expect(order.items).to be_empty
    end
  end

  context 'when an order has transaction_details' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('transaction_details')) }
 
    it 'should have transaction_details' do
      expect(order.transaction_details).not_to be_empty
    end

    it 'should have the correct type of transaction_detail' do
      expect(order.transaction_details.first).to be_an_instance_of(UltraCartXMLParser::TransactionDetail)
    end
  end

  context 'when an order does not have transaction_details' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('no_transaction_details')) }

    it 'should have an empty transaction_details' do
      expect(order.transaction_details).to be_empty
    end

  end

  # IN stands for Inserting
  # ToDo: Don't have example XML for the IN stage

  # QS stands for Quote Sent
  # ToDo: Don't have example XML for the QS stage

  # QR stands for Quote Received
  # ToDo: Don't have example XML for the QR stage

  # PC stands for Pending Clearance
  # ToDo: Don't have example XML for the PC stage

  # PO stands for Pre-Order
  context 'when order is in stage PO' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('po')) }

    include_examples 'it has the common attributes'
    include_examples 'it does not include shipping data'
    include_examples 'it does not include payment processing data'
    include_examples 'it includes payment data'
    include_examples 'customer subscribed to mailing list'

    it 'returns a valid current_stage' do
      expect(order.current_stage).to eq('PO')
    end

    it 'returns a valid payment_status' do
      expect(order.payment_status).to eq('Unprocessed')
    end
  end

  # AR stands for Accounts Receivable
  context 'when order is in stage AR' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('ar')) }

    include_examples 'it has the common attributes'
    include_examples 'it does not include shipping data'
    include_examples 'it does not include payment processing data'
    include_examples 'it includes payment data'
    include_examples 'customer subscribed to mailing list'

    it 'returns a valid current_stage' do
      expect(order.current_stage).to eq('AR')
    end

    it 'returns a valid payment_status' do
      expect(order.payment_status).to eq('Unprocessed')
    end
  end

  # SD stands for Shipping Department
  context 'when order is in stage SD' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('sd')) }

    include_examples 'it has the common attributes'
    include_examples 'it does not include shipping data'
    include_examples 'it includes payment processing data'
    include_examples 'it includes payment data'
    include_examples 'customer subscribed to mailing list'

    it 'returns a valid current_stage' do
      expect(order.current_stage).to eq('SD')
    end

    it 'returns a valid payment_status' do
      expect(order.payment_status).to eq('Processed')
    end
  end

  # CO stands for Complete
  context 'when order is in stage CO' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('co')) }

    include_examples 'it has the common attributes'
    include_examples 'it includes shipping data'
    include_examples 'it includes payment data'
    include_examples 'customer subscribed to mailing list'

    it 'returns a valid current_stage' do
      expect(order.current_stage).to eq('CO')
    end

    it 'returns a valid payment_status' do
      expect(order.payment_status).to eq('Processed')
    end
  end

  # REJ stands for Rejected
  context 'when order is in stage REJ' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('rej')) }

    include_examples 'it has the common attributes'
    include_examples 'it does not include shipping data'
    include_examples 'it includes payment data'
    include_examples 'customer subscribed to mailing list'

    it 'returns a valid current_stage' do
      expect(order.current_stage).to eq('REJ')
    end

    it 'returns a valid payment_status' do
      expect(order.payment_status).to eq('Refunded')
    end
  end

  context 'when no mailing list subscription' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('co_no_sub')) }    

    include_examples 'customer did not subscribe to mailing list'
  end
end
