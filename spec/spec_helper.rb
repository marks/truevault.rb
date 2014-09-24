#we need the actual library file
require_relative '../lib/truevault'

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'
require 'dotenv'
require 'vcr'
require 'turn'

Dotenv.load

Turn.config do |c|
	c.format  = :pretty
	c.natural = true
end

REDACTED_STRING = "REDACTED_ID"

VCR.configure do |c|
	c.cassette_library_dir = 'spec/fixtures/truevault_cassettes'
	c.hook_into :webmock
	c.default_cassette_options = { :match_requests_on => [:method], :record => :new_episodes }
	c.before_record do |interaction|
		interaction.request.body.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, REDACTED_STRING)
		interaction.request.uri.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, REDACTED_STRING)
		interaction.response.body.gsub!(/(\S{8}-\S{4}-\S{4}-\S{4}-\S{12})/, REDACTED_STRING)
	end

end

def random_string(length = 10)
	(0...length).map { (65 + rand(26)).chr }.join
end
