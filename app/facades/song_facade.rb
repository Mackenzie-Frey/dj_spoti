class SongFacade
  def initialize(user)
    @user = user
  end

  def current_song
    data = service.currently_playing
    Song.new(data)
  end

  def service
    SpotifyService.new(@user)
  end
end
