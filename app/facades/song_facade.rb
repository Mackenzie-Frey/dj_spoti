class SongFacade
  def initialize(token)
    @token = token
  end

  def current_song
    data = service.currently_playing
    Song.new(data)
  end

  def service
    SpotifyService.new(@token)
  end
end
