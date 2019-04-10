require 'rails_helper'

describe 'SpotifyClient' do
  before :each do
    @token = 'token'
    @service = SpotifyService.new(@token)

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

      expect(top_plays).to be_a(String)
      expect(top_plays.length).to be(114)
      expect(top_plays.count(',')).to eq(4)
      expect(top_plays).to eq("3LjhVl7GzYsza1biQjTpaN,3JhNCzhSMTxs9WLGJJxWOY,6beUvFUlKliUYJdLOXNj9C,5BcAKTbp20cv7tC5VqPFoC,1vCWHaC5f2uS3yhpwWbIA6")
    end

    it '#recommended_playlist(id_collection)' do
      artist_id1 = '3LjhVl7GzYsza1biQjTpaN'
      artist_id2 = '3JhNCzhSMTxs9WLGJJxWOY'
      artist_id3 = '6beUvFUlKliUYJdLOXNj9C'
      id_collection = "#{artist_id1},#{artist_id2},#{artist_id3}"

      json_response = File.open('fixtures/example_playlist_recommended.json')
      stub_request(:get, "https://api.spotify.com/v1/recommendations?seed_artists=#{id_collection}")
      .to_return(status: 200, body: json_response)

      recommended_playlist = @service.recommended_playlist(id_collection)

      expect(recommended_playlist).to eq(["spotify:track:4IlBZXHTwY7DoxA4piiHtM", "spotify:track:2LNdH3B2gCOw3Uh1jIXG3Z"])
    end
  end
end

# SpotifyService.new(token).party_tracks
