
class CurrentSongChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_song"
  end

  # def play(data)
  #   ActionCable.server.broadcast "current_song", song: data['song']
  # end



end
