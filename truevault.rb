require 'rubygems'
require 'bundler/setup' 
Bundler.require


# Custom parser class for TrueVault API
class TrueVaultParser < HTTParty::Parser
  SupportedFormats.merge!({"application/octet-stream" => :octet_stream})

  def parse
    case format
      when :html
        body
      when :json
        JSON.parse(body)
      when :octet_stream
        JSON.parse(Base64.decode64(body))
      else
        body
    end
  end

end

# see https://www.truevault.com/rest-api.html for full documentation
class TrueVaultClient
  include HTTParty
  require 'json'
  require 'base64'

  # debug_output
  base_uri 'https://api.truevault.com'
  parser TrueVaultParser

  def default_options_to_merge_with
  	{:basic_auth => {:username => @api_key, :password => nil}}
  end

  def hash_to_base64_json(hash = {})
    Base64.encode64(hash.to_json)
  end

  # api_key         should be a valid API key
  # api_ver         should be a valid API version (ex 'v1')
  def initialize(api_key, api_version = 'v1')
    @api_key = api_key
    @api_ver = api_version
  end

  # vault_id        should be a valid vault ID
  # document_id     should be a valid document ID
  # document_data   should be a Ruby Hash. Method will convert it to JSON and base64 encode as required
  def create_document(vault_id, document_data, options = {})
    options.merge!(default_options_to_merge_with)
    options[:query] = {:document => hash_to_base64_json(document_data)}
    self.class.post("/#{@api_ver}/vaults/#{vault_id}/documents", options)
  end

  def get_document(vault_id, document_id, options = {})
    options.merge!(default_options_to_merge_with)
    self.class.get("/#{@api_ver}/vaults/#{vault_id}/documents/#{document_id}", options)
  end

  def delete_document(vault_id, document_id, options = {})
    options.merge!(default_options_to_merge_with)
    self.class.delete("/#{@api_ver}/vaults/#{vault_id}/documents/#{document_id}", options)
  end

  def update_document(vault_id, document_id, document_data, options = {})
    options.merge!(default_options_to_merge_with)
    options[:query] = {:document => hash_to_base64_json(document_data)}
    self.class.put("/#{@api_ver}/vaults/#{vault_id}/documents/#{document_id}", options)
  end

end

# informal testing
require 'pp'
A_API_KEY = "_____"
A_VAULT_ID = "_____"
tv = TrueVaultClient.new(MARK_API_KEY,'v1')

puts "create a document:"
create_document = tv.create_document(A_VAULT_ID, {"a" => "b"})
pp create_document
puts "\n\n\n"

puts "get that document:"
get_document = tv.get_document(A_VAULT_ID, create_document["document_id"])
pp get_document
puts "\n\n\n"

puts "update that document:"
update_document = tv.update_document(A_VAULT_ID, create_document["document_id"], {"x" => "y"})
pp update_document
puts "\n\n\n"

puts "get that document, for a second time:"
get_document2 = tv.get_document(A_VAULT_ID, create_document["document_id"])
pp get_document2
puts "\n\n\n"

puts "delete that document:"
delete_document = tv.delete_document(A_VAULT_ID, create_document["document_id"])
pp delete_document
puts "\n\n\n"

puts "try to get the deleted document (hint: it shouldnt work):"
get_document3 = tv.get_document(A_VAULT_ID, create_document["document_id"])
pp get_document3
puts "\n\n\n"