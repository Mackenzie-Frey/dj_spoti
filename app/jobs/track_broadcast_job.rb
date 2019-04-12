class TrackBroadcastJob < ApplicationJob
  queue_as :default

  # after_perform do |job|
  #   self.class.set(wait: 5.seconds).perform_later(job.arguments.first, job.arguments.second)
  # end

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
