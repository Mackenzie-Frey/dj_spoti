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

def stub_spotify_top_plays
  json_response = File.open('fixtures/example_top_plays.json')
  stub_request(:get, 'https://api.spotify.com/v1/me/top/artists?limit=5&time_range=medium_term')
  .to_return(status: 200, body: json_response)
end
