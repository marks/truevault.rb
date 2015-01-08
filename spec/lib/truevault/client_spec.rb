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

  describe "list vaults" do
    let(:real_client){ TrueVault::Vault.new(ENV["TV_API_KEY"], ENV["TV_ACCOUNT_ID"], 'v1')}
    let(:list_vaults){ real_client.all}

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
    let(:real_document){ TrueVault::Document.new(ENV["TV_API_KEY"], ENV["TV_ACCOUNT_ID"], 'v1') }
    let(:create_document){ real_document.create(ENV["TV_A_VAULT_ID"],{"a" => "document"})}

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

  describe "create a blob" do
    let(:real_blob){ TrueVault::Blob.new(ENV["TV_API_KEY"], ENV["TV_ACCOUNT_ID"], 'v1')}
    let(:create_blob) do
      file = File.new(File.expand_path(File.dirname(__FILE__))+'/../../fixtures/files/test.pdf', 'rb')
      real_blob.create(ENV["TV_A_VAULT_ID"], file)
    end

    before do
      VCR.insert_cassette 'create_blob'
    end

    after do
      VCR.eject_cassette
    end

    it "must parse the API response from JSON to a Ruby Hash" do
      create_blob.must_be_instance_of Hash
    end

    it "must have been a successful API request" do
      create_blob['result'].must_equal "success"
    end

    it "must have a redacted transaction_id" do
      create_blob['transaction_id'].must_equal REDACTED_STRING
    end

    it "must have a redacted document_id" do
      create_blob['blob_id'].must_equal REDACTED_STRING
    end
  end

  describe "create a user" do
    before do
      @real_client = TrueVault::User.new(ENV["TV_API_KEY"], ENV["TV_ACCOUNT_ID"], 'v1')
      VCR.insert_cassette 'create_user'
      @options = {
      username: "test_user_3",
      password: "password",
      attributes: {
        "id" => "000",
        "name" => "John",
        "type" => "patient"
        }
      }
    end

    after do
      VCR.eject_cassette
    end

    it "should have a success response" do
      @real_client.create(@options)["result"].must_equal "success"
    end
    
  end
end
