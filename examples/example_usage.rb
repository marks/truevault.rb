require_relative '../lib/truevault.rb'

TV_API_KEY = ENV["TV_API_KEY"]
TV_A_VAULT_ID = ENV["TV_A_VAULT_ID"]
TV_ACCOUNT_ID = ENV["TV_ACCOUNT_ID"]
tv = TrueVault::Client.new(TV_API_KEY, TV_ACCOUNT_ID, 'v1')

puts "listing vaults:"
list_vaults = tv.list_vaults
puts "  => #{list_vaults} \n\n\n"

puts "create a document:"
create_document = tv.create_document(TV_A_VAULT_ID, {"a" => "b"})
puts "  => #{create_document} \n\n\n"

puts "get that document:"
get_document = tv.get_document(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{get_document} \n\n\n"

puts "update that document:"
update_document = tv.update_document(TV_A_VAULT_ID, create_document["document_id"], {"x" => "y"})
puts "  => #{update_document} \n\n\n"

puts "get that document, for a second time:"
get_document2 = tv.get_document(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{get_document2} \n\n\n"

puts "delete that document:"
delete_document = tv.delete_document(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{delete_document} \n\n\n"

puts "try to get the deleted document (hint: it shouldnt work):"
get_document3 = tv.get_document(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{get_document3} \n\n\n"


file = File.new(File.expand_path(File.dirname(__FILE__))+'/../spec/fixtures/files/test.pdf', 'rb')
puts "create BLOB:"
create_blob = tv.create_blob(TV_A_VAULT_ID, file)
puts "  => #{create_blob} \n\n\n"

puts "get that BLOB:"
get_blob = tv.get_blob(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{get_blob} \n\n\n"

puts "update that BLOB:"
update_blob = tv.replace_blob(TV_A_VAULT_ID, create_blob["blob_id"], file)
puts "  => #{update_blob} \n\n\n"

puts "get that BLOB (again):"
get_blob2 = tv.get_blob(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{get_blob2} \n\n\n"

puts "delete that BLOB:"
delete_blob = tv.delete_blob(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{delete_blob} \n\n\n"

puts "try to get the deleted BLOB (hint: it shouldnt work):"
get_blob3 = tv.get_blob(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{get_blob3} \n\n\n"
