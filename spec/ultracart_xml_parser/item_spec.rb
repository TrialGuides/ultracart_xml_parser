require 'spec_helper'

describe UltraCartXMLParser::Item do
  shared_examples 'it has the required item fields' do
    it 'has a merchant_id' do
      expect(item.merchant_id).to eq('ABC')
    end

    it 'has an order_id' do
      expect(item.order_id).to eq('ABC-12345')
    end

    it 'can be tax_free' do
      expect(item.tax_free).to eq(false)
    end

    it 'can have free_shipping' do
    expect(item.free_shipping).to eq(false)
    end

    it 'has a discount' do
      expect(item.discount).to eq(0.00)
    end

    it 'has a distribution_center_code' do
      expect(item.distribution_center_code).to eq('DFLT')
    end
  end

  context 'individual item' do
    subject(:item) { UltraCartXMLParser.parse(xml_fixture('items')).first.items.first }

    include_examples 'it has the required item fields'

    it 'has an item_id' do
      expect(item.item_id).to eq('Item-A')
    end

    it 'has a description' do
      expect(item.description).to eq('Item A Description')
    end

    it 'has an accounting_code' do
      expect(item.accounting_code).to eq('Item-A')
    end

    it 'has an item index' do
      expect(item.item_index).to eq(0)
    end

    it 'has an item_weight' do
      expect(item.item_weight).to eq('1 LB')
    end

    it 'has a cost' do
      expect(item.cost).to eq(1.00)
    end

    it 'has a unit_cost_with_discount' do
      expect(item.unit_cost_with_discount).to eq(1.00)
    end

    it 'has a total_cost_with_discount' do
      expect(item.total_cost_with_discount).to eq(1.00)
    end

    it 'has a barcode' do
      expect(item.barcode).to eq('BARCODE-A')
    end

    it 'has a manufacturer_sku' do
      expect(item.manufacturer_sku).to eq('SKU-A')
    end

    it 'has a country_of_origin' do
      expect(item.country_of_origin).to eq('United States')
    end

    it 'can be a kit' do
      expect(item.kit).to eq(false)
    end

    it 'can be part of a kit' do
      expect(item.kit_component).to eq(false)
    end
  end

  context 'item is a kit' do
    subject(:item) { UltraCartXMLParser.parse(xml_fixture('items')).first.items[1] }

    include_examples 'it has the required item fields'

    it 'has an item_id' do
      expect(item.item_id).to eq('Kit-A')
    end

    it 'has a description' do
      expect(item.description).to eq('Kit A Description')
    end

    it 'has an accounting_code' do
      expect(item.accounting_code).to eq('Kit-A')
    end

    it 'has an item index' do
      expect(item.item_index).to eq(1)
    end

    it 'has an item_weight' do
      expect(item.item_weight).to eq('0 LB')
    end

    it 'has a cost' do
      expect(item.cost).to eq(1.00)
    end

    it 'has a unit_cost_with_discount' do
      expect(item.unit_cost_with_discount).to eq(1.00)
    end

    it 'has a total_cost_with_discount' do
      expect(item.total_cost_with_discount).to eq(1.00)
    end

    it 'does not have a barcode' do
      expect(item.barcode).to be_nil
    end

    it 'has a manufacturer_sku' do
      expect(item.manufacturer_sku).to be_nil
    end

    it 'has a blank country_of_origin' do
      expect(item.country_of_origin).to be_nil
    end

    it 'has a blank special_product_type' do
      expect(item.special_product_type).to be_nil
    end

    it 'can be a kit' do
      expect(item.kit).to eq(true)
    end

    it 'can be part of a kit' do
      expect(item.kit_component).to eq(false)
    end
  end

  context 'item is part of a kit' do
    subject(:item) { UltraCartXMLParser.parse(xml_fixture('items')).first.items.last }

    include_examples 'it has the required item fields'

    it 'has an item_id' do
      expect(item.item_id).to eq('Item-C')
    end

    it 'has a description' do
      expect(item.description).to eq('Item C Description')
    end

    it 'has an accounting_code' do
      expect(item.accounting_code).to eq('Item-C')
    end

    it 'has an item index' do
      expect(item.item_index).to eq(3)
    end

    it 'has an item_weight' do
      expect(item.item_weight).to eq('1 LB')
    end

    it 'has a cost' do
      expect(item.cost).to eq(1.00)
    end

    it 'has a unit_cost_with_discount' do
      expect(item.unit_cost_with_discount).to eq(1.00)
    end

    it 'has a total_cost_with_discount' do
      expect(item.total_cost_with_discount).to eq(1.00)
    end

    it 'has a barcode' do
      expect(item.barcode).to eq('BARCODE-C')
    end

    it 'has a manufacturer_sku' do
      expect(item.manufacturer_sku).to eq('SKU-C')
    end

    it 'has a country_of_origin' do
      expect(item.country_of_origin).to eq('United States')
    end

    it 'has a special_product_type' do
      expect(item.special_product_type).to eq('BS')
    end

    it 'can be a kit' do
      expect(item.kit).to eq(false)
    end

    it 'can be part of a kit' do
      expect(item.kit_component).to eq(true)
    end
  end

  describe 'item can have a cost of goods sold' do
    subject(:item) { UltraCartXMLParser.parse(xml_fixture('items')).first.items.first }

    it 'has a cogs' do
      expect(item.cogs).to eq(0.50)
    end

    it 'has an actual_cogs' do
      expect(item.actual_cogs).to eq(0.50)
    end
  end

  describe 'item can have a blank cost of goods sold' do
    subject(:item) { UltraCartXMLParser.parse(xml_fixture('items')).first.items[1] }

    it 'has a blank cogs' do
      expect(item.cogs).to be_nil
    end

    it 'has a blank actual_cogs' do
      expect(item.actual_cogs).to be_nil
    end
  end
end
