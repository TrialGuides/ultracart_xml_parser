require 'spec_helper'

describe UltraCartXMLParser do
  context 'when provided with invalid xml' do
    it 'should raise an exception' do
      expect { UltraCartXMLParser.parse('') }.to raise_error
    end
  end

  context 'when provided with valid xml' do
    subject(:orders) { UltraCartXMLParser.parse(xml_fixture('co')) }

    it 'should return an array of Orders' do
      expect(orders).to be_an_instance_of(Array)
      expect(orders.first).to be_an_instance_of(UltraCartXMLParser::Order)
    end
  end
end
