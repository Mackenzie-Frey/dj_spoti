class TrackBroadcastJobJob < ApplicationJob
  queue_as :default

  def perform(song)
    ActionCable.server.broadcast "current-song", {
      id: song.id,
      name: song.name,
      artists: song.artists,
      album: song.album,
      image: song.image
      }
  end
end
