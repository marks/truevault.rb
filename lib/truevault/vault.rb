require "truevault/client"

module TrueVault
  class Vault < Client
    #####################################
    ###       Vault API Methods       ###
    #####################################

    # list all vaults
    # TVVault.all

    def all
      self.class.get("/#{@api_ver}/vaults", default_options_to_merge_with)
    end

    # creates a vault
    # TVVault.create_vault("name")

    def create(name)
      options = default_options_to_merge_with.merge({ query: { name: name } })
      self.class.post("/#{@api_ver}/vaults", options)
    end

    # find a vault
    # TVVault.find("00000000-0000-0000-0000-000000000000")

    def find(vault_id)
      self.class.get("/#{@api_ver}/vaults/#{vault_id}", default_options_to_merge_with)
    end

    # update a vault
    # TVVault.update("00000000-0000-0000-0000-000000000000", "name")

    def update(vault_id, name)
      options = default_options_to_merge_with.merge({ query: { name: name } })
      self.class.put("/#{@api_ver}/vaults/#{vault_id}", options)
    end

    # delete a vault
    # TVVault.update("00000000-0000-0000-0000-000000000000")

    def delete(vault_id)
      self.class.delete("/#{@api_ver}/vaults/#{vault_id}", default_options_to_merge_with)
    end
  end
end
