class TrackBroadcastJob < ApplicationJob
  queue_as :default
  

  def perform(party_identifier, song)
    ActionCable.server.broadcast "current_song_#{party_identifier}", {
      song: render_song(song),
      party: party_identifier
      }

  end

  private

  def render_song(song)
    ApplicationController.renderer.render(
      partial: 'partials/current_song',
      locals: {
        current_song: CurrentSongFacade.new(song)
      })
  end
end
