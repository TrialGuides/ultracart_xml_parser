require 'spec_helper'

describe UltraCartXMLParser::TransactionDetail do
  subject(:transaction_detail) { UltraCartXMLParser.parse(xml_fixture('transaction_details')).transaction_details.first }

  it 'has a transaction_id' do
    expect(transaction_detail.transaction_id).to eq('12345678')
  end

  it 'has a transaction_gateway' do
    expect(transaction_detail.transaction_gateway).to eq('Authorize.Net 3.1')
  end

  it 'has a transaction_timestamp' do
    expect(transaction_detail.transaction_timestamp).to eq(DateTime.new(2015, 1, 1, 11, 0, 0))
  end

  it 'can be transaction_successful' do
    expect(transaction_detail.transaction_successful).to eq(true)
  end

  it 'should have empty extended_details' do
    expect(transaction_detail.extended_details).not_to eq([])
  end

  it 'should contain extended_detail objects' do
    expect(transaction_detail.extended_details.first).to be_an_instance_of(UltraCartXMLParser::ExtendedDetail)
  end
end
