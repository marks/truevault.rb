require 'truevault/client'

module TrueVault
  class Blob < Client
    #####################################
    ### BLOB (binary file) API Methods
    #####################################

    def create(vault_id, file, options = {:headers => {"Content-Type"=>"application/octet-stream"}})
      options.merge!(default_options_to_merge_with)
      options[:body] = file.read
      self.class.post("/#{@api_ver}/vaults/#{vault_id}/blobs", options)
    end

    def update(vault_id, blob_id, file, options = {:headers => {"Content-Type"=>"application/octet-stream"}})
      options.merge!(default_options_to_merge_with)
      options[:body] = file.read
      self.class.put("/#{@api_ver}/vaults/#{vault_id}/blobs/#{blob_id}", options)
    end

    def delete(vault_id, blob_id, options = {})
      options.merge!(default_options_to_merge_with)
      self.class.delete("/#{@api_ver}/vaults/#{vault_id}/blobs/#{blob_id}", options)
    end

    def find(vault_id, blob_id, options = {})
      options.merge!(default_options_to_merge_with)
      self.class.get("/#{@api_ver}/vaults/#{vault_id}/blobs/#{blob_id}", options)
    end
  end
end