
def CurrentlyPlayingService
  attr_reader :party

  def initialize(party)
    @party = party
  end

  def check_for_track_change
    current_track = SpotifyUser.new(party.admin).currently_playing #=> <#SongObject id: 1234, title: "asdf", album_art: "http://example.com/photo.jpg">

    if current_track.id != party.current_track.id
      party.current_track = current_track
      TrackBroadcastJob.perform_later(track)
    end
  end

end


# in the console or the controller
player = CurrentlyPlayingService.new(party)
player.check_for_track_change

# somewhere in CurrentlyPlayingService
