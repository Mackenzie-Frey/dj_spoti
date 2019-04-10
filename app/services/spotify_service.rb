class SpotifyService
  def initialize(user)
    @user = user
    @token = @user.access_token
    access_token_expired?(@user)
  end

  def currently_playing
    json_for('me/player/currently-playing')
  end

  def top_plays
    json_for('me/top/artists?limit=5&time_range=medium_term')
  end

  def recommended_playlist(id_collection)
    json_for("recommendations?seed_artists=#{id_collection}")
  end

  def json_for(url)
    response = conn.get(url)
    unless response.body == ''
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def conn
    Faraday.new(url: 'https://api.spotify.com/v1/') do |f|
      f.headers['Authorization'] = "Bearer #{@token}"
      f.adapter Faraday.default_adapter
    end
  end

  private

  def access_token_expired?(current_user)
    if (current_user.expires_at - Time.now.utc) < 300
      refresh_token(current_user, encoded_authorization)
    else
      return
    end
  end

  def encoded_authorization
    Base64.strict_encode64("#{ENV["SPOTIFY_CLIENT_ID"]}:#{ENV["SPOTIFY_CLIENT_SECRET"]}")
  end

  def refresh_token(current_user, encoded_authorization)
    json_parsed = JSON.parse(refresh_token_conn(current_user, encoded_authorization))
    current_user.update(access_token: json_parsed["access_token"])
    current_user.update(expires_at: Time.now.utc + 1.hour)
  end

  def refresh_token_conn(current_user, encoded_authorization)
    response = Faraday.post("https://accounts.spotify.com/api/token") do |req|
      req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      req.headers["Authorization"] = "Basic #{encoded_authorization}"
      req.body = {"grant_type":"refresh_token", "refresh_token":"#{current_user.refresh_token}"}
    end
    response.body
  end
end
