def stub_oauth_connection
  OmniAuth.config.test_mode = true
  omniauth_hash = {
    'provider' => 'spotify',
    'uid' => 'fakeId',
    'info' => {'name' => 'Fake Name'},
    'credentials' => { 'token' => 'fakefaketokentoken',
                       'refresh_token' => 'fakefakerefresh',
                       'expires_at' => 1554561894

    }
  }
  OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(omniauth_hash)
end

def guest_login
  OmniAuth.config.test_mode = true
  omniauth_hash = { 'provider' => 'spotify',
                    'uid' => 'guestID',
                    'info' => {'name' => 'Guest'},
                    'credentials' => { 'token' => 'fakefaketokentoken',
                                       'refresh_token' => 'fakefakerefresh',
                                       'expires_at' => 1554561894

                    }
  }
  OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(omniauth_hash)
end
