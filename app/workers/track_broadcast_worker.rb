class TrackBroadcastWorker
  include Sidekiq::Worker

  def perform(song)
    ActionCable.server.broadcast "current_song", {
      id: song.id,
      name: song.name,
      artists: song.artists,
      album: song.album,
      image: song.image
      }
  end
end
