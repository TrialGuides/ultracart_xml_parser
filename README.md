# UltraCart XML Parser

The UltraCart XML Parser is a Ruby interface for interacting with XML files from the UltraCart XML Postback service. 

Objects returned by the parser include:
- Addresses
- Coupons
- Customer Profile
- Transaction Details
- Items

Other fields returned from the parser include:
- Order ID
- Channel Partner Code
- Channel Partner Order ID
- Current Stage
- Payment Status
- Mailing List Subscription

### Reference Documentation

More information regarding UltraCart's XML Postback feature:
- [UltraCart XML Postback Documentation](http://docs.ultracart.com/display/ucdoc/XML+Postback)
- [UltraCart XML Schema](https://secure.ultracart.com/xml/ultracart.xsd)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ultracart_xml_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ultracart_xml_parser

## Usage

```ruby
# Parse the XML string
order = UltraCartXML::Order.parse(xml_contents)

# Get the Order ID
order.order_id
TODO: Document result

# Get the shipping address
order.shipping_address
TODO: Document result

# etc.
```

## Future Improvements

Additional object support should include:
- Option
- Export
- Lot

## Contributing

1. Fork it ( https://github.com/TrialGuides/ultracart_xml_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
