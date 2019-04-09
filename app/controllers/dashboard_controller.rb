class DashboardController < ApplicationController
  def index
    @users = current_party.users  if current_party

    if current_party
      token = current_party.admin.access_token

      current_song = SongFacade.new(token).current_song
      if current_song
        TrackBroadcastJob.perform_later(current_song.serialize_data)
      end
    end

      # ActionCable.server.broadcast "current_song", serialized_data



    # service = CurrentService.new(current_party)
    # service.check_for_track_change
    #
    # TrackBroadcastJob.perform_later(current_party.current_song.serialize_data)
  end


  private

  # def every( time )
  #   Thread.new {
  #       loop do
  #           sleep(time)
  #           yield
  #       end
  #   }
  #
  #
  # end


end
