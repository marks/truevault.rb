require './truevault.rb'
require 'pp'

A_API_KEY = "_____"
A_VAULT_ID = "_____"
tv = TrueVaultClient.new(A_API_KEY,'v1')

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