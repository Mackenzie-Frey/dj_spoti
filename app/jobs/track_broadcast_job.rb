class TrackBroadcastJob < ApplicationJob
  queue_as :default

  def perform(song)
    ActionCable.server.broadcast "current-song", {
      song: render_song(song)
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
