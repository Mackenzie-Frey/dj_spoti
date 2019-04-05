class SpotifyClient
  def initialize(token)
    @token = token
  end

  def conn
    Faraday.new(url: 'https://api.spotify.com/')
  end
end
