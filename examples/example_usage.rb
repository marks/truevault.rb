require_relative '../lib/truevault.rb'
require 'pp'

TV_API_KEY = ENV["TV_API_KEY"]
TV_A_VAULT_ID = ENV["TV_A_VAULT_ID"]
TV_ACCOUNT_ID = ENV["TV_ACCOUNT_ID"]
tv = TrueVault::Client.new(TV_API_KEY, TV_ACCOUNT_ID, 'v1')

puts "listing vaults:"
list_vaults = tv.list_vaults
pp list_vaults
puts "\n\n\n"

puts "create a document:"
create_document = tv.create_document(TV_A_VAULT_ID, {"a" => "b"})
pp create_document
puts "\n\n\n"

puts "get that document:"
get_document = tv.get_document(TV_A_VAULT_ID, create_document["document_id"])
pp get_document
puts "\n\n\n"

puts "update that document:"
update_document = tv.update_document(TV_A_VAULT_ID, create_document["document_id"], {"x" => "y"})
pp update_document
puts "\n\n\n"

puts "get that document, for a second time:"
get_document2 = tv.get_document(TV_A_VAULT_ID, create_document["document_id"])
pp get_document2
puts "\n\n\n"

puts "delete that document:"
delete_document = tv.delete_document(TV_A_VAULT_ID, create_document["document_id"])
pp delete_document
puts "\n\n\n"

puts "try to get the deleted document (hint: it shouldnt work):"
get_document3 = tv.get_document(TV_A_VAULT_ID, create_document["document_id"])
pp get_document3