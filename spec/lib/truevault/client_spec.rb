require_relative '../../spec_helper'

describe TrueVault::Client do
  
  it "must include httparty methods" do
  	TrueVault::Client.must_include HTTParty
  end

  it "must have the base url set to the TrueVault endpoint" do
  	TrueVault::Client.base_uri.must_equal 'https://api.truevault.com'
	end
  

end