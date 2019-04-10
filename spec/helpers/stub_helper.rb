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

def stub_recommended_playlist
  id_collection = "6beUvFUlKliUYJdLOXNj9C,3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6"
  json_response = File.open('fixtures/example_playlist_recommended.json')
  stub_request(:get, "https://api.spotify.com/v1/recommendations?seed_artists=#{id_collection}")
  .to_return(status: 200, body: json_response)
end

def stub_select_seeds
  # all_ids = ["3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,6beUvFUlKliUYJdLOXNj9C,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6"]
  # id_collection = "6beUvFUlKliUYJdLOXNj9C,3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6"
  # allow_any_instance_of(Playlist).to receive(:select_seeds).with(all_ids).and_return(id_collection)

  all_ids = ["3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,6beUvFUlKliUYJdLOXNj9C,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6"]
  id_collection = "6beUvFUlKliUYJdLOXNj9C,3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6"

  allow_any_instance_of(Playlist).to receive(:select_seeds) {id_collection}
  allow_any_instance_of(Playlist).to receive(:select_seeds).with(all_ids).and_return(id_collection)
end
