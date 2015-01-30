require 'spec_helper'

describe UltraCartXML::ExtendedDetail do
  subject(:extended_detail) { UltraCartXML::Order.parse(xml_fixture('transaction_details')).transaction_details.extended_details.last }

  it 'should have an extended_detail_name'  { expect(extended_detail).to equal('UC Refund Date/Time') }
  it 'should have an extended_detail_value' { expect(extended_detail).to equal('Thu Jan 01 11:00:00 EDT 2015') }
end
