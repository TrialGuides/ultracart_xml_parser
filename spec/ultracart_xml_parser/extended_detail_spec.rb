require 'spec_helper'

describe UltraCartXMLParser::ExtendedDetail do
  subject(:extended_detail) { UltraCartXMLParser::Order.parse(xml_fixture('transaction_details')).transaction_details.last.extended_details.last }

  it 'should have an extended_detail_name' do
    expect(extended_detail.extended_detail_name).to eq('UC Refund Date/Time')
  end

  it 'should have an extended_detail_value' do
    expect(extended_detail.extended_detail_value).to eq('Thu Jan 01 11:00:00 EDT 2015')
  end
end
