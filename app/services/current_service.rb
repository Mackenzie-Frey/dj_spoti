
class CurrentService
  attr_reader :party

  def initialize(party)
    @party = party
  end


  def check_for_track_change
    current_song = SongFacade.new(self.party.admin.access_token).current_song
    #=> <#SongObject id: 1234, title: "asdf", album_art: "http://example.com/photo.jpg">
    if current_song.id != @party.current_song.id

      party.current_song = current_song
      "Track changed"
      TrackBroadcastJob.perform_later(track)
    end

  end

end


# # in the console or the controller
# player = CurrentlyPlayingService.new(Party.last)
# player.check_for_track_change
