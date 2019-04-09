class SongFacade
  def initialize(token)
    @token = token
  end

  def current_song
    data = service.currently_playing
    if data && data[:is_playing]
      Song.new(data)
    end
  end

  def service
    SpotifyService.new(@token)
  end
end
