require 'truevault/client'

module TrueVault
  class User < Client
    #####################################
    ###        USER API Methods       ###
    #####################################

    # creates a user
    # TVUser.create_user(
    #   username: "bar",
    #   password: "foo",
    #   attributes: {
    #     "id": "000",
    #     "name": "John",
    #     "type": "patient"
    #     }
    #   }
    # )

    def create(options = {})
      query = { 
        query: {
          username: options[:username],
          password: options[:password],
          attributes: hash_to_base64_json(options[:attributes])
          }
        }
      new_options = default_options_to_merge_with.merge(query)
      self.class.post("/#{@api_ver}/users", new_options)
    end

    # retrieve a user
    # TVUser.get_user("00000000-0000-0000-0000-000000000000")

    def find(user_id, read_attributes="01")
      options = default_options_to_merge_with.merge({ query: { full: read_attributes} })
      self.class.get("/#{@api_ver}/users/#{user_id}", options)
    end

    # list all users
    # TVUser.list_users

    def all(read_attributes="01")
      options = default_options_to_merge_with.merge({ query: { full: read_attributes} })
      self.class.get("/#{@api_ver}/users", options)
    end

    # update a user
    # TVUser.update_user("00000000-0000-0000-0000-000000000000",
    #   username: "bar",
    #   password: "foo",
    #   attributes: {
    #     "id": "000",
    #     "name": "John",
    #     "type": "patient"
    #     }
    #   }
    # )

    def update(user_id, options = {})
      query = { 
        query: {
          username: options[:username],
          password: options[:password],
          attributes: hash_to_base64_json(options[:attributes])
          }
        }
      new_options = default_options_to_merge_with.merge(query)
      self.class.put("/#{@api_ver}/users/#{user_id}", new_options)
    end

    # delete a user
    # TVUser.delete_user("00000000-0000-0000-0000-000000000000")

    def delete(user_id)
      self.class.delete("/#{@api_ver}/users/#{user_id}", default_options_to_merge_with)
    end
  end
end