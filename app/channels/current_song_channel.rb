
class CurrentSongChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current-song"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # def receive(payload)
  #   ActionCable.server.broadcast('current_song', {song: payload["song"]})
  # end

end
