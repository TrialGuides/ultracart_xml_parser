# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ultracart_xml_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "ultracart_xml_parser"
  spec.version       = UltracartXmlParser::VERSION
  spec.authors       = ["Michael Lippold", "Peggy Condon"]
  spec.email         = ["michael@trialguides.com", "peggy@trialguides.com"]
  spec.summary       = %q{Ruby interface for interacting the UltraCart XML Postback data.}
  spec.description   = %q{The UltraCart XML Parser is a Ruby interface for interacting with XML files from the UltraCart XML Postback service.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6.6"
  spec.add_dependency "carmen", "~> 1.0.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
