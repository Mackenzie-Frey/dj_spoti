require 'rails_helper'

describe 'SongFacade' do
  before :each do
    @facade = SongFacade.new('token')
    @song_json = File.open('./fixtures/example_current_song.json')
    stub_request(:get, 'https://api.spotify.com/v1/me/player/currently-playing')
      .to_return(status: 200, body: @song_json)
  end

  it 'exists' do
    expect(@facade).to be_a(SongFacade)
  end

  describe 'instance methods' do
    it 'service' do
      expect(@facade.service).to be_a(SpotifyService)
    end

    it '#current_song' do
      expect(@facade.current_song).to be_a(Song)
    end
  end
end
