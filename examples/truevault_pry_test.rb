require "dotenv"
require_relative "./lib/truevault.rb"
Dotenv.load
TV_API_KEY = ENV["TV_API_KEY"]
TV_A_VAULT_ID = ENV["TV_A_VAULT_ID"]
TV_ACCOUNT_ID = ENV["TV_ACCOUNT_ID"]
TV = TrueVault::Client.new(TV_API_KEY, TV_ACCOUNT_ID, 'v1')