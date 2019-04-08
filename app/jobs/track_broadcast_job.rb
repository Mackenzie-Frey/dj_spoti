class TrackBroadcastJob < ApplicationJob
  queue_as :default

  def perform(song)
    ActionCable.server.broadcast "current-song", {
      song: render_song(song)
      }
  end

  private

  # def render_song(song)
  #   DashboardController.render(
  #     partial: 'current_song',
  #     locals: {
  #       current_song: song
  #     }
  #   )
  # end
end
