require_relative '../../spec_helper'

describe TrueVault::Client do  
  
  it "must include httparty methods" do
  	TrueVault::Client.must_include HTTParty
  end

  it "must have the base url set to the TrueVault endpoint" do
  	TrueVault::Client.base_uri.must_equal 'https://api.truevault.com'
	end

  it "must require one argument (API key) upon instantiation" do
    -> {TrueVault::Client.new}.must_raise ArgumentError, "wrong number of arguments (0 for 1)"
  end

  it "must store the first argument as the API key" do
    random_string = (0...10).map { (65 + rand(26)).chr }.join
    TrueVault::Client.new(random_string).instance_variable_get("@api_key").must_equal random_string
  end

	describe "GET list of vaults" do
		let(:client){ TrueVault::Client.new('anything')}

		before do
			VCR.insert_cassette 'list_vaults'
		end

		after do
			VCR.eject_cassette
		end

		it "records the fixture" do
			tv = TrueVault::Client.new(ENV["TV_API_KEY"], ENV["TV_ACCOUNT_ID"], 'v1')
			tv.list_vaults
		end

		it "must respond to list_vaults" do 
			client.must_respond_to :list_vaults
		end

    it "must parse the API response from JSON to a Ruby Hash" do
      client.list_vaults.must_be_instance_of Hash
    end

    it "must have an array of vaults" do
      client.list_vaults['vaults'].must_be_instance_of Array
    end

    it "must have been a successful API request" do
      client.list_vaults['result'].must_equal "success"
    end

    it "must have a redacted transaction_id " do
      client.list_vaults['transaction_id'].must_equal REDACTED_STRING
    end

	end

end

