require 'truevault/client'

module TrueVault
  class Authorization < Client
    #####################################
    ###   AUTHORIZATION API Methods   ###
    #####################################

    # logs in a user
    # the account_id is different from user id response
    # TVAuth.login(
    #   username: "bar",
    #   password: "foo",
    #   account_id: "00000000-0000-0000-0000-000000000000"
    # )

    def login(options = {})
      body = { 
        body: {
          username: options[:username],
          password: options[:password],
          account_id: options[:account_id]
        }
      }
      self.class.post("/#{@api_ver}/auth/login", body)
    end

    # log out with the access token from logging in
    # TVAuth.verify()

    def logout(access_token)
      self.class.post("/#{@api_ver}/auth/logout", auth(access_token))
    end

    # verify whether or not the user is logged in
    # TVAuth.verify("00000000-0000-0000-0000-000000000000")

    def verify(access_token)
      self.class.get("/#{@api_ver}/auth/me", auth(access_token))
    end

    private

    def auth(access_token)
      { basic_auth: { username: access_token } }
    end
  end
end