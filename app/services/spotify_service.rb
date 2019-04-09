class SpotifyService
  def initialize(token)
    @token = token
  end

  def currently_playing
    json_for('me/player/currently-playing')
  end

  def refresh_token(body)
    response = refresh_token_conn(body)
    JSON.parse(response.body, symbolize_names: true)
  end

  def top_plays
    json_for('me/top/artists?limit=5&time_range=medium_term')
  end

  def recommended_playlist(id_collection)
    json_for("recommendations?seed_artists=#{id_collection}")
  end

  def json_for(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.spotify.com/v1/') do |f|
      f.headers['Authorization'] = "Bearer #{@token}"
      f.adapter Faraday.default_adapter
    end
  end

  def refresh_token_conn(body)
    Faraday.post('https://accounts.spotify.com/api/token', body)
  end
end
