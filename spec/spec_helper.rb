#we need the actual library file
require_relative '../lib/truevault'

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

Turn.config do |c|
  c.format  = :outline
  c.trace   = true
  c.natural = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/truevault_cassettes'
  c.hook_into :webmock

  c.before_record do |interaction|
  	interaction.request.body.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, '<REDACTED_ID>')
  	interaction.request.uri.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, '<REDACTED_ID>')
    interaction.response.body.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, '<REDACTED_ID>')
  end

end
