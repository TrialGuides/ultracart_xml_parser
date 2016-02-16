require 'spec_helper'

describe UltraCartXMLParser::Address do
  shared_examples 'it has all of the required address fields' do
    it 'includes a first_name' do
      expect(address.first_name).to eq('Tester')
    end

    it 'includes a last_name' do
      expect(address.last_name).to eq('Testerson')
    end

    it 'includes an address1' do
      expect(address.address1).to eq('2350 NW York St')
    end

    it 'includes a city' do
      expect(address.city).to eq('Portland')
    end

    it 'includes a state' do
      expect(address.state).to eq('OR')
    end

    it 'includes a zip' do
      expect(address.zip).to eq('97210')
    end

    it 'includes a country' do
      expect(address.country).to eq('United States')
    end

    it 'includes a country code' do
      expect(address.country_code).to eq('US')
    end
  end

  shared_examples 'it has a title' do
    it 'can have a title' do
      expect(address.title).to eq('Dr.')
    end
  end

  shared_examples 'it has a blank title' do
    it 'can have a blank title' do
      expect(address.title).to be_nil
    end
  end

  shared_examples 'it has a company' do
    it 'can have a company' do
      expect(address.company).to eq('Test Inc.')
    end
  end

  shared_examples 'it has a blank company' do
    it 'can have a blank company' do
      expect(address.company).to be_nil
    end
  end

  shared_examples 'it has an address2' do
    it 'can have an address2' do
      expect(address.address2).to eq('Suite A')
    end
  end

  shared_examples 'it has a blank address2' do
    it 'can have a blank address2' do
      expect(address.address2).to be_nil
    end
  end

  context 'when the address is a shipping address' do
    describe 'it has all of the required fields' do
      subject(:address) { UltraCartXMLParser.parse(xml_fixture('address')).first.ship_to_address }

      include_examples 'it has all of the required address fields'
    end

    describe 'it can have the optional fields present' do
      subject(:address) { UltraCartXMLParser.parse(xml_fixture('address')).first.bill_to_address }

      include_examples 'it has a title'
      include_examples 'it has a company'
      include_examples 'it has an address2'
    end

    describe 'it can have the optional fields missing' do
      subject(:address) { UltraCartXMLParser.parse(xml_fixture('address_no_optional')).first.bill_to_address }

      include_examples 'it has a blank title'
      include_examples 'it has a blank company'
      include_examples 'it has a blank address2'
    end
  end

  context 'when the address is a billing address' do
    describe 'it has all of the required fields' do
      subject(:address) { UltraCartXMLParser.parse(xml_fixture('address')).first.bill_to_address }

      include_examples 'it has all of the required address fields'
    end

    describe 'it can have the optional fields present' do
      subject(:address) { UltraCartXMLParser.parse(xml_fixture('address')).first.bill_to_address }

      include_examples 'it has a title'
      include_examples 'it has a company'
      include_examples 'it has an address2'
    end

    describe 'it can have the optional fields missing' do
      subject(:address) { UltraCartXMLParser.parse(xml_fixture('address_no_optional')).first.bill_to_address }

      include_examples 'it has a blank title'
      include_examples 'it has a blank company'
      include_examples 'it has a blank address2'
    end
  end
end
