
class CurrentSongChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current-song"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast 'current-song',
            {song: data["song"]}
  end

end
