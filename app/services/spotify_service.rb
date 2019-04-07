class SpotifyService
  def initialize(token)
    @token = token
  end

  def currently_playing
    json_for('me/player/currently-playing')
  end

  def extract_artist_ids(result)
    result[:items].map do |artist|
      artist[:id]
    end
  end

  def top_plays
    result = json_for('me/top/artists?limit=5&time_range=medium_term')
    extract_artist_ids(result)
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
end
