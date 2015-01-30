require 'spec_helper'

describe UltraCartXML::Item do
  context 'individual item' do
    subject(:item) { UltraCartXML::Order.parse(xml_fixture('items')).items.first }

    required_item_fields(item)

    it 'has an item_id'                 { expect(item.item_id).to equal('Item-A') }
    it 'has a description'              { expect(item.description).to equal('Item A Description') }
    it 'has an accounting_code'         { expect(item.accounting_code).to equal('Item-A') }
    it 'has an item index'              { expect(item.item_index).to equal(0) }
    it 'has an item_weight'             { expect(item.item_weight).to equal('1 LB') }
    it 'has a cost'                     { expect(item.cost).to equal(1.00) }
    it 'has a unit_cost_with_discount'  { expect(item.unit_cost_with_discount).to equal(1.00) }
    it 'has a total_cost_with_discount' { expect(item.total_cost_with_discount).to equal(1.00) }
    it 'has a barcode'                  { expect(item.barcode).to equal('BARCODE-A') }
    it 'has a manufacturer_sku'         { expect(item.manufacturer_sku).to equal('SKU-A') }
    it 'has a country_of_origin'        { expect(item.country_of_origin).to equal('United States') }
    it 'can be a kit'                   { expect(item.kit).to be_false }
    it 'can be part of a kit'           { expect(item.kit_component).to be_false }
  end

  context 'item is a kit' do
    subject(:item) { UltraCartXML::Order.parse(xml_fixture('items')).items[1] }

    required_item_fields(item)

    it 'has an item_id'                   { expect(item.item_id).to equal('Kit-A') }
    it 'has a description'                { expect(item.description).to equal('Kit A Description') }
    it 'has an accounting_code'           { expect(item.accounting_code).to equal('Kit-A') }
    it 'has an item index'                { expect(item.item_index).to equal(1) }
    it 'has an item_weight'               { expect(item.item_weight).to equal('0 LB') }
    it 'has a cost'                       { expect(item.cost).to equal(1.00) }
    it 'has a unit_cost_with_discount'    { expect(item.unit_cost_with_discount).to equal(1.00) }
    it 'has a total_cost_with_discount'   { expect(item.total_cost_with_discount).to equal(1.00) }
    it 'does not have a barcode'          { expect(item.barcode).to be_nil }
    it 'has a manufacturer_sku'           { expect(item.manufacturer_sku).to be_nil }
    it 'has a blank country_of_origin'    { expect(item.country_of_origin).to be_nil }
    it 'has a blank special_product_type' { expect(item.special_product_type).to be_nil }
    it 'can be a kit'                     { expect(item.kit).to be_true }
    it 'can be part of a kit'             { expect(item.kit_compontent).to be_false }
  end

  context 'item is part of a kit' do
    subject(:item) { UltraCartXML::Order.parse(xml_fixture('items')).items.last }

    required_item_fields(item)

    it 'has an item_id'                 { expect(item.item_id).to equal('Item-C') }
    it 'has a description'              { expect(item.description).to equal('Item C Description') }
    it 'has an accounting_code'         { expect(item.accounting_code).to equal('Item-C') }
    it 'has an item index'              { expect(item.item_index).to equal(3) }
    it 'has an item_weight'             { expect(item.item_weight).to equal('1 LB') }
    it 'has a cost'                     { expect(item.cost).to equal(1.00) }
    it 'has a unit_cost_with_discount'  { expect(item.unit_cost_with_discount).to equal(1.00) }
    it 'has a total_cost_with_discount' { expect(item.total_cost_with_discount).to equal(1.00) }
    it 'has a barcode'                  { expect(item.barcode).to equal('BARCODE-C') }
    it 'has a manufacturer_sku'         { expect(item.manufacturer_sku).to equal('SKU-C') }
    it 'has a country_of_origin'        { expect(item.country_of_origin).to equal('United States') }
    it 'has a special_product_type'     { expect(item.special_product_type).to equal('BS') }
    it 'can be a kit'                   { expect(item.kit).to be_false }
    it 'can be part of a kit'           { expect(item.kit_compontent).to be_true }
  end

  describe 'item can have a cost of goods sold' do
    subject(:item) { UltraCartXML::Order.parse(xml_fixture('items')).items.first }

    it 'has a cogs'         { expect(item.cogs).to equal(0.50) }
    it 'has an actual_cogs' { expect(item.actual_cogs).to equal(0.50) }
  end

  describe 'item can have a blank cost of goods sold' do
    subject(:item) { UltraCartXML::Order.parse(xml_fixture('items')).items[1] }

    it 'has a blank cogs'        { expect(item.cogs).to be_nil }
    it 'has a blank actual_cogs' { expect(item.actual_cogs).to be_nil }
  end

  def required_item_fields(item)
    it 'has a merchant_id'              { expect(item.merchant_id).to equal('ABC') }
    it 'has an order_id'                { expect(item.order_id).to equal('ABC-12345') }
    it 'can be tax_free'                { expect(item.tax_free).to be_false }
    it 'can have free_shipping'         { expect(item.free_shipping).to be_false }
    it 'has a discount'                 { expect(item.discount).to equal(0.00) }
    it 'has a distribution_center_code' { expect(item.distribution_center_code).to equal('DFLT') }
  end
end
