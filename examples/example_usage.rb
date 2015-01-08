require_relative '../lib/truevault.rb'

TV_API_KEY = ENV["TV_API_KEY"]
TV_A_VAULT_ID = ENV["TV_A_VAULT_ID"]
TV_ACCOUNT_ID = ENV["TV_ACCOUNT_ID"]
tv_document = TrueVault::Document.new(TV_API_KEY, TV_ACCOUNT_ID, 'v1')
tv_user = TrueVault::User.new(TV_API_KEY, TV_ACCOUNT_ID, 'v1')
tv_blob = TrueVault::Blob.new(TV_API_KEY, TV_ACCOUNT_ID, 'v1')
tv_vault = TrueVault::Vault.new(TV_API_KEY, TV_ACCOUNT_ID, 'v1')

puts "listing vaults:"
list_vaults = tv_vault.list_vaults
puts "  => #{list_vaults} \n\n\n"

puts "create a document:"
create_document = tv_document.create(TV_A_VAULT_ID, {"a" => "b"})
puts "  => #{create_document} \n\n\n"

puts "get that document:"
get_document = tv_document.find(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{get_document} \n\n\n"

puts "update that document:"
update_document = tv_document.update(TV_A_VAULT_ID, create_document["document_id"], {"x" => "y"})
puts "  => #{update_document} \n\n\n"

puts "get that document, for a second time:"
get_document2 = tv_document.find(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{get_document2} \n\n\n"

puts "delete that document:"
delete_document = tv_document.delete(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{delete_document} \n\n\n"

puts "try to get the deleted document (hint: it shouldnt work):"
get_document3 = tv_document.find(TV_A_VAULT_ID, create_document["document_id"])
puts "  => #{get_document3} \n\n\n"


file = File.new(File.expand_path(File.dirname(__FILE__))+'/../spec/fixtures/files/test.pdf', 'rb')
puts "create BLOB:"
create_blob = tv_blob.create(TV_A_VAULT_ID, file)
puts "  => #{create_blob} \n\n\n"

puts "get that BLOB:"
get_blob = tv_blob.find(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{get_blob} \n\n\n"

puts "update that BLOB:"
update_blob = tv_blob.update(TV_A_VAULT_ID, create_blob["blob_id"], file)
puts "  => #{update_blob} \n\n\n"

puts "get that BLOB (again):"
get_blob2 = tv_blob.find(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{get_blob2} \n\n\n"

puts "delete that BLOB:"
delete_blob = tv_blob.delete(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{delete_blob} \n\n\n"

puts "try to get the deleted BLOB (hint: it shouldnt work):"
get_blob3 = tv_blob.find(TV_A_VAULT_ID, create_blob["blob_id"])
puts "  => #{get_blob3} \n\n\n"
