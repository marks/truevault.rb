require_relative '../../spec_helper'

describe TrueVault::Client do  
  rs1 = random_string
  rs2 = random_string
  let(:fake_client){ TrueVault::Client.new(rs1,rs2)}
  let(:real_client){ TrueVault::Client.new(ENV["TV_API_KEY"], ENV["TV_ACCOUNT_ID"], 'v1')}

  it "parent class must include httparty methods" do
  	fake_client.class.must_include HTTParty
  end

  it "parent class must have the base url set to the TrueVault endpoint" do
  	fake_client.class.base_uri.must_equal 'https://api.truevault.com'
	end

  it "must require one argument (API key) upon instantiation" do
    -> {TrueVault::Client.new}.must_raise ArgumentError, "wrong number of arguments (0 for 2..3)"
  end

  it "must store the first argument as the API key" do
    fake_client.instance_variable_get("@api_key").must_equal rs1
  end

  methods = [:list_vaults, :create_document, :get_document, :update_document, :delete_document]
  methods.each do |method|
    it "must respond to method '#{method}'" do
      fake_client.must_respond_to method
    end
  end
  
  describe "list vaults" do
    let(:list_vaults){ real_client.list_vaults}

    before do
      VCR.insert_cassette 'list_vaults'
    end

    after do
      VCR.eject_cassette
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
    let(:create_document){ real_client.create_document(ENV["TV_A_VAULT_ID"],{"a" => "document"})}

    before do
      VCR.insert_cassette 'create_document'
    end

    after do
      VCR.eject_cassette
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

