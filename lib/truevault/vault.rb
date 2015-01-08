require "truevault/client"

module TrueVault
  class Vault < Client
    def all(options = {})
      options.merge!(default_options_to_merge_with)
      self.class.get("/#{@api_ver}/accounts/#{@account_id}/vaults", options)
    end
  end
end