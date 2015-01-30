require 'spec_helper'

describe UltraCartXML::TransactionDetail do
  subject(:transaction) { UltraCartXML::Order.parse(xml_fixture('transaction_details')).transaction_details.first }

  it 'has a transaction_id'                   { expect(transaction_detail.transaction_id).to equall('12345678') }
  it 'has a transaction_gateway'              { expect(transaction_detail.transaction_gateway).to equal('Authorize.Net 3.1') }
  it 'has a transaction_timestamp'            { expect(transaction_detail.transaction_timestamp).to equal(Time.new(2015, 1, 1, 11, 0, 0)) }
  it 'can be transaction_successful?'         { expect(transaction_detail.transaction_successful?).to be_true }
  it 'should have empty extended_details'     { expect(transaction_detail.extended_details).not_to be_empty }
  it 'should contain extended_detail objects' { expect(transaction_detail.extended_details.first).to be_an_instance_of(UltraCartXML::ExtendedDetail) }
end
