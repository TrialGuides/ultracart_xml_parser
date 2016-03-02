require 'spec_helper'

describe UltraCartXMLParser::CustomerProfile do
  context 'when the customer profile is present' do
    subject(:customer_profile) { UltraCartXMLParser.parse(xml_fixture('customer_profile')).first.customer_profile }

    it 'has an email' do
      expect(customer_profile.email).to eq('tester@example.com')
    end

    it 'has terms' do
      expect(customer_profile.terms).to eq('Net 30')
    end

    it 'has a qb_class' do
      expect(customer_profile.qb_class).to eq('123')
    end

    it 'has a track_separately flag' do
      expect(customer_profile.track_separately).to eq(true)
    end

    it 'has a tax_exempt flag' do
      expect(customer_profile.tax_exempt).to eq(true)
    end
  end

  context 'when the customer profile is not present' do
    subject(:customer_profile) { UltraCartXMLParser.parse(xml_fixture('customer_profile')).last.customer_profile }

    it 'has a nil customer_profile' do
      expect(customer_profile).to be_nil
    end
  end
end
