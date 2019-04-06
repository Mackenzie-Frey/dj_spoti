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

# for current user
# get song_ids from a party, for each user
# get the array from the party, no matter how long and take top five? or random five?

    it '#party_playlist' do
      json = @service.json_for('me/player/currently-playing')
      ['3LjhVl7GzYsza1biQjTpaN', '3JhNCzhSMTxs9WLGJJxWOY', '6beUvFUlKliUYJdLOXNj9C',
        '5BcAKTbp20cv7tC5VqPFoC', '1vCWHaC5f2uS3yhpwWbIA6']
    end
  end

end
