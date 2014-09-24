# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'truevault/version'

Gem::Specification.new do |spec|
  spec.name          = "truevault"
  spec.version       = TrueVault::VERSION
  spec.authors       = ["Mark Silverberg"]
  spec.email         = ["mark@socialhealthinsights.com"]
  spec.summary       = %q{Ruby client for True Vault API}
  spec.description   = %q{A super quick Ruby client for TrueVault ("handles HIPAA compliance so that you don’t have to") powered by HTTParty.}
  spec.homepage      = "https://github.com/marks/truevault.rb"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "httparty", "~> 0.11"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake",    "~> 10.1"
  spec.add_development_dependency "webmock", "1.11"
  spec.add_development_dependency "vcr",     "~> 2.5"
  spec.add_development_dependency "turn",    "~> 0.9"
  spec.add_development_dependency "dotenv"
end
