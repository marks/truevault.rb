require_relative '../../spec_helper'

describe TrueVault::Client do  
  random_string = (0...10).map { (65 + rand(26)).chr }.join
  let(:client){ TrueVault::Client.new(random_string)}

  it "parent class must include httparty methods" do
  	client.class.must_include HTTParty
  end

  it "parent class must have the base url set to the TrueVault endpoint" do
  	client.class.base_uri.must_equal 'https://api.truevault.com'
	end

  it "must require one argument (API key) upon instantiation" do
    -> {TrueVault::Client.new}.must_raise ArgumentError, "wrong number of arguments (0 for 1)"
  end

  it "must store the first argument as the API key" do
    client.instance_variable_get("@api_key").must_equal random_string
  end

  methods = [:list_vaults, :create_document, :get_document, :update_document, :delete_document]
  methods.each do |method|
    it "must respond to method '#{method}'" do
      client.must_respond_to method
    end
  end
  
  describe "list vaults" do
    let(:list_vaults){ TrueVault::Client.new('anything').list_vaults}

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

    it "must parse the API response from JSON to a Ruby Hash" do
      list_vaults.must_be_instance_of Hash
    end

    it "must have an array of vaults" do
      list_vaults['vaults'].must_be_instance_of Array
    end

    it "must have been a successful API request" do
      list_vaults['result'].must_equal "success"
    end

    it "must have a redacted transaction_id " do
      list_vaults['transaction_id'].must_equal REDACTED_STRING
    end
  end


  describe "create a document" do
    let(:create_document){ TrueVault::Client.new('anything').create_document('a_vault_id',{"a" => "document"})}

    before do
      VCR.insert_cassette 'create_document'
    end

    after do
      VCR.eject_cassette
    end

    it "records the fixture" do
      tv = TrueVault::Client.new(ENV["TV_API_KEY"], ENV["TV_ACCOUNT_ID"], 'v1')
      tv.create_document(ENV["TV_A_VAULT_ID"], {"a key" => "a value", "an array key" => [0,1,2,3], "a hash key" => {"a" => "b", "x" => "y"}})
    end

    it "must parse the API response from JSON to a Ruby Hash" do
      create_document.must_be_instance_of Hash
    end

    it "must have been a successful API request" do
      create_document['result'].must_equal "success"
    end

    it "must have a redacted transaction_id" do
      create_document['transaction_id'].must_equal REDACTED_STRING
    end

    it "must have a redacted document_id" do
      create_document['document_id'].must_equal REDACTED_STRING
    end

  end

end

