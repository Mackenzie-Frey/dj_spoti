require 'rails_helper'

describe 'SpotifyClient' do
  before :each do
    @token = ''
    @client = SpotifyClient.new(@token)
  end

  it 'exists' do
    expect(@client).to be_a(SpotifyClient)
  end

  describe 'instance methods' do
    it '#conn' do
      expect(@client.conn).to be_a(Faraday::Connection)
      expect(@client.conn.build_url.hostname)
        .to eq('api.spotify.com/')
      expect(@student_service.conn.build_url.path)
        .to eq('v1/')
    end
  end

end
