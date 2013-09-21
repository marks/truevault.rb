#we need the actual library file
require_relative '../lib/truevault'

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

Turn.config do |c|
	c.format  = :pretty
	c.natural = true
end

VCR.configure do |c|
	c.cassette_library_dir = 'spec/fixtures/truevault_cassettes'
	c.hook_into :webmock
	c.default_cassette_options = { :match_requests_on => [:method] }
	c.before_record do |interaction|
		interaction.request.body.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, 'REDACTED_ID')
		interaction.request.uri.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, 'REDACTED_ID')
		interaction.response.body.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, 'REDACTED_ID')
	end

end
