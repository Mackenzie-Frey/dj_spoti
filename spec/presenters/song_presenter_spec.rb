require 'rails_helper'

describe 'SongFacade' do
  before :each do
    user = User.create(spotify_id: "",
                       name: "Manoj Pant",
                       created_at: Time.now,
                       updated_at: Time.now - 3200,
                       access_token: '',
                       refresh_token: "AQCzIKW8-VCySiDZQ-OIn8LZHWPCG-TbBhxIHdgPkp738tNEtBtyV8YJ-ccTkhua-80oF1AI4GOwNm4kIdhnwdR7NY6o99y_bBSSWBf_-_HfnP5xNZQb9dt6jYLNE71Qxm7wow",
                       expires: true,
                       expires_at: 1554837955)
    @facade = SongFacade.new(user)
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
