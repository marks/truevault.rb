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
          # TODO find a better way of doing this
          # The issue is that no matter what it gets frmo TV
          # the ContentType is always octet_stream
          begin
            JSON.parse(Base64.decode64(body))
          rescue JSON::ParserError
            file = Tempfile.new('blob')
            file.binmode
            file.write(body)
            file.rewind
            file
          end
        else
          body
      end
    end
  end

  class Client
    include HTTParty
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

    # api_key         should be a valid TrueVault API key
    # account_id      should be a valid TrueVault account ID
    # api_version     should be a valid API version (ex 'v1')
    def initialize(api_key, account_id, api_version = 'v1')
      @api_key = api_key
      @account_id = account_id
      @api_ver = api_version
      instance_variables.each do |variable|
        raise ArgumentError, "#{variable} should not be nil or blank" if instance_variable_get(variable.to_sym).to_s == ""
      end
    end
  end
end