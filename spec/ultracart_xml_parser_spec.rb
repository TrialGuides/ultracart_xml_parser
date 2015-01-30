require 'spec_helper'

describe UltraCartXML::Order do
  context 'when provided with invalid xml' do
    it 'should raise an exception' { expect(UltraCartXML::Order.parse('')).to raise_exception }
  end

  context 'when an order has a shipping address and a billing address' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('address')) }

    it 'should have a billing_address'  { expect(order.billing_address).to be_an_instance_of(UltraCartXML::Address) }
    it 'should have a shipping_address' { expect(order.shipping_address).to be_an_instance_of(UltraCartXML::Address) }
  end

  context 'when an order only hase a billing address' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('address_no_shipping')) }

    it 'should have a billing_address'  { expect(order.billing_address).to be_an_instance_of(UltraCartXML::Address) }
    it 'should have a shipping_address' { expect(order.shipping_address).to be_nil }
  end

  context 'when an order has coupons' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('coupons')) }

    it 'should have a coupon'                    { expect(order.coupons).no_to be_empty }
    it 'should have the correct type of coupons' { expect(order.coupons.first).to be_an_instance_of(UltraCartXML::Coupon) }
  end

  context 'when an order does not have coupons' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('no_coupons')) }

    it 'should have no coupons' { expect(order.coupons).to be_empty }
  end

  context 'when an order has items' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('items')) }

    it 'should have items'                     { expect(order.items).not_to be_empty }
    it 'should have the correct type of items' { expect(order.items.first).to be_an_instance_of(UltraCartXML::Item) }
  end

  context 'when an order has no items' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('no_items')) }

    it 'should have no items' { expect(order.items).to be_empty }
  end

  context 'when an order has transaction_details' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('transaction_details')) }
 
    it 'should have transaction_details'                    { expect(order.transaction_details).not_to be_empty }
    it 'should have the correct type of transaction_detail' { expect(order.transaction_details.first).to be_an_instance_of(UltraCartXML::TransactionDetail) }
  end

  context 'when an order does not have transaction_details' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('no_transaction_details')) }

    it 'should have an empty transaction_details' { expect(order.transaction_details).to be_empty }
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
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('po')) }

    static_order_data(order)
    no_order_shipping_data(order)
    no_payment_processing_data(order)
    included_order_payment_data(order)
    subscribed_to_mailing_list(order)

    it 'returns a valid current_stage'  { expect(order.current_stage).to equal('PO') }
    it 'returns a valid payment_status' { expect(order.payment_status).to equal('Unprocessed') }
  end

  # AR stands for Accounts Receivable
  context 'when order is in stage AR' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('ar')) }

    static_order_data(order)
    no_order_shipping_data(order)
    no_payment_processing_data(order)
    included_order_payment_data(order)
    subscribed_to_mailing_list(order)

    it 'returns a valid current_stage'  { expect(order.current_stage).to equal('AR') }
    it 'returns a valid payment_status' { expect(order.payment_status).to equal('Unprocessed') }
  end

  # SD stands for Shipping Department
  context 'when order is in stage SD' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('sd')) }

    static_order_data(order)
    no_order_shipping_data(order)
    included_payment_processing_data(order)
    included_order_payment_data(order)
    subscribed_to_mailing_list(order)

    it 'returns a valid current_stage'  { expect(order.current_stage).to equal('SD') }
    it 'returns a valid payment_status' { expect(order.payment_status).to equal('Processed') }
  end

  # CO stands for Complete
  context 'when order is in stage CO' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('co')) }

    static_order_data(order)
    included_order_shipping_data(order)
    included_order_payment_data(order)
    subscribed_to_mailing_list(order)

    it 'returns a valid current_stage'  { expect(order.current_stage).to equal('CO') }
    it 'returns a valid payment_status' { expect(order.payment_status).to equal('Processed') }
  end

  # REJ stands for Rejected
  context 'when order is in stage REJ' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('rej')) }

    static_order_data(order)
    included_order_shipping_data(order)
    included_order_payment_data(order)
    subscribed_to_mailing_list(order)

    it 'returns a valid current_stage'                     { expect(order.current_stage).to equal('REJ') }
    it 'returns a valid payment_status'                    { expect(order.payment_status).to equal('Refunded') }
  end

  context 'when no mailing list subscription' do
    subject(:order) { UltraCartXML::Order.parse(xml_fixture('co_no_sub')) }    

    not_subscribed_to_mailing_list(order)
  end

  # Attributes that don't change between states
  def static_order_data(order)
    it 'returns a valid merchant_id'                       { expect(order.merchant_id).to equal('ABC') }
    it 'returns a valid order_id'                          { expect(order.order_id)).to equal('ABC-12345') }
    it 'returns a valid order_date'                        { expect(order.order_date).to equal(Time.new(2015, 1, 1, 12, 0, 0)) }
    it 'returns a valid order_type'                        { expect(order.order_type).to equal('credit card') }
    it 'returns a valid tax_county'                        { expect(order.tax_county).to be_nil }
    it 'returns a valid shipping_method'                   { expect(order.shipping_method).to equal('FedEx: Ground') }
    it 'returns a valid lift_gate'                         { expect(order.lift_gate?).to be false }
    it 'returns a valid gift'                              { expect(order.gift?).to be false }
    it 'returns a valid email'                             { expect(order.email).to equal('tester@example.com') }
    it 'returns a valid day_phone'                         { expect(order.day_phone).to equal('(503) 555-1212') }
    it 'returns a valid evening_phone'                     { expect(order.evening_phone).to equal('(503) 555-1212') }
    it 'returns a valid fax'                               { expect(order.fax).to be_nil }
    it 'returns a valid weight'                            { expect(order.weight).to equal('1 LB') }
    it 'returns a valid subtotal'                          { expect(order.subtotal).to equal('100.00') }
    it 'returns a valid tax_rate'                          { expect(order.tax_rate).to equal('0.00000') }
    it 'returns a valid tax'                               { expect(order.tax).to equal('0.00') }
    it 'returns a valid shipping_handling_total'           { expect(order.shipping_handling_total).to equal('10.00') }
    it 'returns a valid shipping_handling_total_discount'  { expect(order.shipping_handling_total_discount).to equal('0.00') }
    it 'returns a valid surcharge_transaction_fee'         { expect(order.surcharge_transaction_fee).to equal('0.00') }
    it 'returns a valid surcharge_transaction_percentage'  { expect(order.surcharge_transaction_percentage).to equal('0.0000') }
    it 'returns a valid surcharge'                         { expect(order.surcharge).to equal('0.00') }
    it 'returns a valid total'                             { expect(order.total).to equal('110.00') }
    it 'returns a valid currency_code'                     { expect(order.currency_code).to be_nil }
    it 'returns a valid actual_profit_analyzed'            { expect(order.actual_profit_analyzed?).to be false }
    it 'returns a valid actual_profit_review'              { expect(order.actual_profit_review?).to be false }
    it 'returns a valid actual_shipping'                   { expect(order.actual_shipping).to be_nil }
    it 'returns a valid actual_other_cost'                 { expect(order.actual_other_cost).to be_nil }
    it 'returns a valid actual_fulfillment'                { expect(order.actual_fulfillment).to be_nil }
    it 'returns a valid actual_payment_processing'         { expect(order.actual_payment_processing).to be_nil }
    it 'returns a valid actual_profit'                     { expect(order.actual_profit).to be_nil }
    it 'returns a valid gift_certificate_amount'           { expect(order.gift_certificate_amount).to equal('0.00') }
    it 'returns a valid special_instructions'              { expect(order.special_instructions).to be_nil }
    it 'returns a valid merchant_notes'                    { expect(order.merchant_notes).to be_nil }
    it 'returns a valid subtotal_discount'                 { expect(order.subtotal_discount).to equal('0.00') }
    it 'returns a valid gift_charge_accounting_code'       { expect(order.gift_charge_accounting_code).to be_nil }
    it 'returns a valid gift_wrap_accounting_code'         { expect(order.gift_wrap_accounting_code).to be_nil }
    it 'returns a valid surcharge_accounting_code'         { expect(order.surcharge_accounting_code).to be_nil }
    it 'returns a valid shipping_method_accounting_code'   { expect(order.shipping_method_accounting_code).to be_nil }
    it 'returns a valid payment_method_accounting_code'    { expect(order.payment_method_accounting_code).to be_nil }
    it 'returns a valid payment_method_deposit_to_account' { expect(order.payment_method_deposit_to_account).to be_nil }
    it 'returns a valid tax_country_accounting_code'       { expect(order.tax_country_accounting_code).to be_nil }
    it 'returns a valid tax_state_accounting_code'         { expect(order.tax_state_accounting_code).to be_nil }
    it 'returns a valid tax_county_accounting_code'        { expect(order.tax_county_accounting_code).to be_nil }
    it 'returns a valid tax_city_accounting_code'          { expect(order.tax_city_accounting_code).to be_nil }
    it 'returns a valid tax_postal_code_accounting_code'   { expect(order.tax_postal_code_accounting_code).to be_nil }
    it 'returns a valid referral_code'                     { expect(order.referral_code).to be_nil }
    it 'returns a valid advertising_source'                { expect(order.advertising_source).to equal('Existing Customer') }
    it 'returns a valid screen_branding_theme_code'        { expect(order.screen_branding_theme_code).to equal('THEME-X') }
    it 'returns a valid insureship_available'              { expect(order.insureship_available?).to be_false }
    it 'returns a valid insureship_separate'               { expect(order.insureship_separate?).to be_false }
    it 'returns a valid insureship_wanted'                 { expect(order.insureship_wanted?).to be_false }
    it 'returns a valid has_customer_profile'              { expect(order.has_customer_profile?).to be_true }
    it 'returns a valid customer_ip_address'               { expect(order.customer_ip_address).to equal('127.0.0.1') }
  end

  def no_order_payment_data(order)
    it 'returns a valid card_type'                         { expect(order.card_type).to be_nil }
    it 'returns a valid card_number'                       { expect(order.card_number).to be_nil }
    it 'returns a valid card_exp_month'                    { expect(order.card_exp_month).to be_nil }
    it 'returns a valid card_exp_year'                     { expect(order.card_exp_year).to be_nil }
    it 'returns a valid card_auth_ticket'                  { expect(order.card_auth_ticket).to be_nil }
    it 'returns a valid payment_method'                    { expect(order.payment_method).to be_nil }
  end

  def included_order_payment_data(order)
    it 'returns a valid card_type'                         { expect(order.card_type).to equal('MasterCard') }
    it 'returns a valid card_number'                       { expect(order.card_number).to equal('1234') }
    it 'returns a valid card_exp_month'                    { expect(order.card_exp_month).to equal('10') }
    it 'returns a valid card_exp_year'                     { expect(order.card_exp_year).to equal('2020') }
    it 'returns a valid card_auth_ticket'                  { expect(order.card_auth_ticket).to be_nil }
    it 'returns a valid payment_method'                    { expect(order.payment_method).to equal('Credit Card') }
  end

  def no_payment_processed_data(order)
    it 'returns a valid payment_date'                      { expect(order.payment_date).to be_nil }
    it 'returns a valid payment_date_time'                 { expect(order.payment_date_time).to be_nil }
  end

  def payment_processed_data(order)
    it 'returns a valid payment_date'                      { expect(order.payment_date).to equal(Date.new(2015, 1, 1)) }
    it 'returns a valid payment_date_time'                 { expect(order.payment_date_time).to equal(Time.new(2015, 1, 1, 14, 00, 00)) }
  end

  def no_order_shipping_data(order)
    it 'returns a valid shipping_date'                     { expect(order.shipping_date).to be_nil }
    it 'returns a valid shipping_date_time'                { expect(order.shipping_date_time).to be_nil }
    it 'returns a valid shipping_tracking_number'          { expect(order.shipping_tracking_number).to be_nil }
  end

  def included_order_shipping_data(order)
    it 'returns a valid shipping_date'                     { expect(order.shipping_date).to equal(Date.new(2015, 1, 1) }
    it 'returns a valid shipping_date_time'                { expect(order.shipping_date_time).to equal(Time.new(2015, 1, 1, 14, 30, 00) }
    it 'returns a valid shipping_tracking_number'          { expect(order.shipping_tracking_number).to equal('123456789012345') }
  end

  def subscribed_to_mailing_list(order)
    it 'returns a valid mailing_list'                      { expect(order.mailing_list?).to be_true }
  end

  def not_subscribed_to_mailing_list(order)
    it 'returns a valid mailing_list'                      { expect(order.mailing_list?).to be_false }
  end
end
