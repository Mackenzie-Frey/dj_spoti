
class CurrentSongChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_song"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
