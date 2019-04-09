require 'rails_helper'

describe 'SpotifyClient' do
  before :each do
    user = User.create(spotify_id: "31plzrfruxb34tdffhr4vbimuxl4",
                       name: "Manoj Pant",
                       created_at: Time.now,
                       updated_at: Time.now - 3200,
                       access_token: "",
                       refresh_token: "",
                       expires: true,
                       expires_at: 1554837955)

    @service = SpotifyService.new(user)

    @song_json = File.open('./fixtures/example_current_song.json')
    stub_request(:get, 'https://api.spotify.com/v1/me/player/currently-playing')
      .to_return(status: 200, body: @song_json)
  end

  it 'exists' do
    expect(@service).to be_a(SpotifyService)
  end

  describe 'instance methods' do
    it '#conn' do
      expect(@service.conn).to be_a(Faraday::Connection)
      expect(@service.conn.build_url.hostname)
        .to eq('api.spotify.com')
      expect(@service.conn.build_url.path)
        .to eq('/v1/')
      expect(@service.conn.headers['Authorization']).to eq("Bearer #{@token}")
    end

    it '#json_for(url)' do
      current_song = @service.json_for('me/player/currently-playing')
      expect(current_song[:progress_ms]).to eq(33359)
      expect(current_song[:item][:album][:artists][0][:name]).to eq('Disclosure')
    end

    it '#currently_playing' do
      json = @service.json_for('me/player/currently-playing')
      current_song = @service.currently_playing
      expect(current_song).to eq(json)
    end

    it '#top_plays' do
      json_response = File.open('fixtures/example_top_plays.json')
      stub_request(:get, 'https://api.spotify.com/v1/me/top/artists?limit=5&time_range=medium_term')
      .to_return(status: 200, body: json_response)

      top_plays = @service.top_plays

      expect(top_plays[:items]).to be_a(Array)
      expect(top_plays[:items][0][:name]).to eq('Hayley Kiyoko')
      expect(top_plays[:items][0][:id]).to eq('3LjhVl7GzYsza1biQjTpaN')
      expect(top_plays[:items][1][:name]).to eq('Macklemore')
      expect(top_plays[:items][1][:id]).to eq('3JhNCzhSMTxs9WLGJJxWOY')
    end

    it '#party_playlist' do
      artist_id1 = '3LjhVl7GzYsza1biQjTpaN'
      artist_id2 = '3JhNCzhSMTxs9WLGJJxWOY'
      artist_id3 = '6beUvFUlKliUYJdLOXNj9C'
      id_collection = "#{artist_id1},#{artist_id2},#{artist_id3}"

      json_response = File.open('fixtures/example_playlist_recommended.json')
      stub_request(:get, "https://api.spotify.com/v1/recommendations?seed_artists=#{id_collection}")
      .to_return(status: 200, body: json_response)

      recommended_playlist = @service.recommended_playlist(id_collection)

      expect(recommended_playlist[:tracks][0][:artists][0][:name]).to eq('Macklemore')
      expect(recommended_playlist[:tracks][0][:album][:name]).to eq('GEMINI')
      expect(recommended_playlist[:tracks][0][:name]).to eq('Zara (feat. Abir)')
      expect(recommended_playlist[:tracks][0][:popularity]).to eq(51)

      expect(recommended_playlist[:tracks][1][:artists][0][:name]).to eq("Hayley Kiyoko")
      expect(recommended_playlist[:tracks][1][:album][:name]).to eq("Expectations")
      expect(recommended_playlist[:tracks][1][:name]).to eq("Mercy / Gatekeeper")
      expect(recommended_playlist[:tracks][1][:popularity]).to eq(50)
    end
  end
end

describe 'refres_token method ' do
  it 'refreshes when user.updated at is more than 55 minutes old from time now', :vcr do
    token = "BQAJEXoQfBGIOb0Jq34v_8RBA40OuVmx24SK1ZGD48Z0PPJ-dL-0bRHajAHJs3gN5dWqKk0syHwIRUTL0wZ7dK1Kf3sHq2YiJu-Iai2SvS7kM0Diye4Ck6W3b0Ei3ktfWe7yopA-I-ndvfux-wq9Zj-IhGp66dHcLjJaEV8mLLZLJyfYmhCpzXfjDQhqR59d5LrpGiM4"
    user = User.create(spotify_id: "31plzrfruxb34tdffhr4vbimuxl4",
                       name: "Manoj Pant",
                       created_at: Time.now,
                       updated_at: Time.now - 2.hour,
                       access_token: token,
                       refresh_token: "abced",
                       expires: true,
                       expires_at: 1554837955)
    service = SpotifyService.new(user)

    expect(user.access_token).to_not eq(token) ##since it is updated!!
  end

  it 'does not refresh when user.updated at is less than 55 minutes old from time now', :vcr do
    token = ""
    user = User.create(spotify_id: "31plzrfruxb34tdffhr4vbimuxl4",
                       name: "Manoj Pant",
                       created_at: Time.now,
                       updated_at: Time.now - 3200,
                       access_token: token,
                       refresh_token: "",
                       expires: true,
                       expires_at: 1554837955)
    service = SpotifyService.new(user)

    expect(user.access_token).to eq(token) ##since it is not updated!!
  end
end
