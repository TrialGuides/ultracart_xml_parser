require 'bundler/setup'
Bundler.setup

require 'ultracart_xml_parser'

module Fixtures
  def xml_fixture(path)
    File.read(File.join(File.dirname(__FILE__), 'fixtures', "#{path}.xml"))
  end
end

RSpec.configure do |config|
  config.include Fixtures
end
