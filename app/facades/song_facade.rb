class SongFacade
  def initialize(user)
    @user = user
  end

  def current_song
    data = service.currently_playing
    if data && data[:is_playing]
      Song.new(data)
    end
  end

  def service
    SpotifyService.new(@user)
  end
end
