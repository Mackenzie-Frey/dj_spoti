class SongFacade
  def initialize(current_user)
    @token = ''
    @current_user = current_user
    access_token_expired?(current_user)
  end

  def current_song
    data = service.currently_playing
    Song.new(data)
  end

  def service
    SpotifyService.new(@token)
  end


  private
  def access_token_expired?(current_user)
    binding.pry
    if (Time.now.utc - current_user.updated_at) > 3300
      body = {
        grant_type: "authorization_code",
        code: SessionsController.code,
        redirect_uri: 'http://localhost:3000/auth/spotify/callback',
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }
      service.refresh_token(body)

    else
      return
    end
  end



end
