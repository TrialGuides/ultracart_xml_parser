require 'spec_helper'

describe UltraCartXMLParser::Coupon do
  shared_examples 'it has the required coupon fields' do
    it 'has a merchant_id' do
      expect(coupon.merchant_id).to equal('ABC')
    end

    it 'has an order_id' do
      expect(coupon.order_id).to equal('ABC-12345')
    end

    it 'has a coupon_code' do
      expect(coupon.coupon_code).to equal('COUPON-X')
    end

    it 'has a base_coupon_code' do
      expect(coupon.base_coupon_code).to equal('COUPON-X')
    end
  end

  context 'coupon has an accounting code' do
#    subject(:coupon) { UltraCartXMLParser::Order.parse(xml_fixture('coupons')).coupons.first }
    subject(:coupon) { UltraCartXMLParser::Order.parse('') }

    it_behaves_like 'it has the required coupon fields'

    it 'has a coupon_accounting_code' do
      expect(coupon.coupon_accounting_code).to equal('COUPON-X')
    end
  end

  context 'coupon does not have an accounting code' do
#    subject(:coupon) { UltraCartXMLParser::Order.parse(xml_fixture('coupon_no_acct')).coupons.first }
    subject(:coupon) { UltraCartXMLParser::Order.parse('') }

    it_behaves_like 'it has the required coupon fields'

    it 'has a blank coupon_accounting_code' do
      expect(coupon.coupon_accounting_code).to be_nil
    end
  end
end
