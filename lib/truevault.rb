require 'rubygems'
require 'bundler/setup' 
Bundler.require

module TrueVault
  # Custom parser class for TrueVault API
  class Parser < HTTParty::Parser
    SupportedFormats.merge!({"application/octet-stream" => :octet_stream})

    def parse
      case format
        when :html
          body
        when :json
          JSON.parse(body)
        when :octet_stream
          JSON.parse(Base64.decode64(body))
        else
          body
      end
    end

  end

  class Client
    include HTTMultiParty # include HTTParty
    require 'json'
    require 'base64'

    # debug_output
    base_uri 'https://api.truevault.com'
    parser Parser

    def default_options_to_merge_with
      {:basic_auth => {:username => @api_key, :password => nil}}
    end

    def hash_to_base64_json(hash = {})
      Base64.encode64(hash.to_json)
    end

    # api_key         should be a valid API key
    # api_ver         should be a valid API version (ex 'v1')
    def initialize(api_key, account_id = nil, api_version = 'v1')
      @api_key = api_key
      @account_id = account_id
      @api_ver = api_version
      instance_variables.each do |variable|
        raise ArgumentError, "#{variable} should not be nil or blank" if instance_variable_get(variable.to_sym).to_s == ""
      end
    end

    ####################################################
    ### JSON (structured text data store) API Methods
    ####################################################

    # vault_id        should be a valid vault ID
    # document_id     should be a valid document ID
    # document_data   should be a Ruby Hash. Method will convert it to JSON and base64 encode as required
    def create_document(vault_id, document_data, options = {})
      options.merge!(default_options_to_merge_with)
      options[:query] = {:document => hash_to_base64_json(document_data)}
      self.class.post("/#{@api_ver}/vaults/#{vault_id}/documents", options)
    end

    def get_document(vault_id, document_id, options = {})
      options.merge!(default_options_to_merge_with)
      self.class.get("/#{@api_ver}/vaults/#{vault_id}/documents/#{document_id}", options)
    end

    def delete_document(vault_id, document_id, options = {})
      options.merge!(default_options_to_merge_with)
      self.class.delete("/#{@api_ver}/vaults/#{vault_id}/documents/#{document_id}", options)
    end

    def update_document(vault_id, document_id, document_data, options = {})
      options.merge!(default_options_to_merge_with)
      options[:query] = {:document => hash_to_base64_json(document_data)}
      self.class.put("/#{@api_ver}/vaults/#{vault_id}/documents/#{document_id}", options)
    end

    def list_vaults(options = {})
      options.merge!(default_options_to_merge_with)
      self.class.get("/#{@api_ver}/accounts/#{@account_id}/vaults", options)
    end

    #####################################
    ### BLOB (binary file) API Methods
    #####################################

    def create_blob(options = {})
      puts "Coming soon"
    end

    def replace_blob(options = {})
      puts "Coming soon"
    end

    def delete_blob(options = {})
      puts "Coming soon"
    end

    def get_blob(options = {})
      puts "Coming soon"
    end

  end


end