require 'spec_helper'

describe UltraCartXMLParser do
  context 'when provided with invalid xml' do
    it 'should raise an exception' do
      expect { UltraCartXMLParser.parse('') }.to raise_error
    end
  end

  context 'when provided with valid xml' do
    subject(:order) { UltraCartXMLParser.parse(xml_fixture('co')) }

    it 'should return an Order' do
      expect(order).to be_an_instance_of(UltraCartXMLParser::Order)
    end
  end
end
