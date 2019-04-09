class SpotifyService
  def initialize(token)
    @token = token
  end

  def currently_playing
    json_for('me/player/currently-playing')
  end

  def extract_artist_ids(result)
    ids = ""
    result[:items].each do |artist|
      ids += "," + artist[:id]
    end
    binding.pry
    ids
  end

  def top_plays
    result = json_for('me/top/artists?limit=5&time_range=medium_term')
    extract_artist_ids(result)
  end

  def extract_track_ids(result)
    result[:tracks].map do |track|
      "spotify:track:#{track[:id]}"
    end
  end

  def recommended_playlist(id_collection)
    result = json_for("recommendations?seed_artists=#{id_collection}")
    extract_track_ids(result)
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
