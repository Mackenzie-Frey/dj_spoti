class SpotifyUser
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def currently_playing
    SpotifyPlayerService.new(@user).current_track
  end
end

 # current_track = SpotifyUser.new(party.admin).currently_playing #=>
 # <#SongObject id: 1234, title: "asdf", album_art: "http://example.com/photo.jpg">
