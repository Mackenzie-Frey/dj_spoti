
class CurrentSongChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_song_#{params[:party]}"
  end

  def unsubscribe

  end
  #
  # def receive(data)
  #   ActionCable.server.broadcast("current_song_#{params[:party]}", data)
  # end



end
