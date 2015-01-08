require "truevault/client"

module TrueVault
  class Schema < Client
    #####################################
    ###      Schema API Methods       ###
    #####################################

    # list all schemas for a vault
    # TVSchema.all(00000000-0000-0000-0000-000000000000)

    def all(vault_id)
      default_options_to_merge_with
      self.class.get("/#{@api_ver}/vaults/#{vault_id}/schemas", default_options_to_merge_with)
    end

    # creates a vault
    # TVSchema.create("00000000-0000-0000-0000-000000000000",
    #   {
    #    "name"=> "user",
    #    "fields"=> [
    #       {
    #        "name" => "first_name",
    #        "index" => true,
    #        "type" => "string"
    #       },
    #       {
    #        "name" => "street",
    #        "index" => false,
    #        "type" => "string"

    #       },
    #       {
    #        "name" => "internal_id",
    #        "index" => true,
    #        "type" => "integer"
    #       },
    #       {
    #        "name" => "created_date",
    #        "index" => true,
    #        "type" => "date"
    #       }
    #     ]
    #   }
    # )

    def create(vault_id, schema)
      encoded_schema = hash_to_base64_json(schema)
      options = default_options_to_merge_with.merge({ query: { schema: encoded_schema } })
      self.class.post("/#{@api_ver}/vaults/#{vault_id}/schemas", options)
    end

    # retrieve a vault
    # in the response TrueVault stores the schema id as just the id field
    # TVSchema.find("00000000-0000-0000-0000-000000000000", "00000000-0000-0000-0000-000000000000")

    def find(vault_id, schema_id)
      self.class.get("/#{@api_ver}/vaults/#{vault_id}/schemas/#{schema_id}", default_options_to_merge_with)
    end

    # update a schema
    # TVSchema.update("00000000-0000-0000-0000-000000000000", "00000000-0000-0000-0000-000000000000",
    #   {
    #    "name"=> "user",
    #    "fields"=> [
    #       {
    #        "name" => "first_name",
    #        "index" => true,
    #        "type" => "string"
    #       },
    #       {
    #        "name" => "street",
    #        "index" => false,
    #        "type" => "string"

    #       },
    #       {
    #        "name" => "internal_id",
    #        "index" => true,
    #        "type" => "integer"
    #       },
    #       {
    #        "name" => "created_date",
    #        "index" => true,
    #        "type" => "date"
    #       }
    #     ]
    #   }
    # )

    def update(vault_id, schema_id, schema)
      encoded_schema = hash_to_base64_json(schema)
      options = default_options_to_merge_with.merge({ query: { schema: encoded_schema } })
      self.class.get("/#{@api_ver}/vaults/#{vault_id}/schemas/#{schema_id}", options)
    end

    # delete a schema
    # TVSchema.delete("00000000-0000-0000-0000-000000000000", "00000000-0000-0000-0000-000000000000")

    def delete(vault_id, schema_id)
      self.class.delete("/#{@api_ver}/vaults/#{vault_id}/schemas/#{schema_id}", default_options_to_merge_with)
    end
  end
end