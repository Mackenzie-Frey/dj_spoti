class Api::V1::PartyController < ApplicationController
  def show
    party = Party.find_by(identifier: params["identifier"])
    current_song = SongFacade.new(party.admin).current_song
    if current_song
      TrackBroadcastJob.perform_later(party.identifier, SongFacade.new(party.admin).current_song.serialize_data)
    end

    render json: {
      message: "Song Updated!"
    }
  end

end
