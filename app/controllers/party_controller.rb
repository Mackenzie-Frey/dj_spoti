class PartyController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    party = Party.new(party_params)
    party.identifier = SecureRandom.urlsafe_base64.to_s
    party.admin = current_user
    party.users << current_user
    # TrackBroadcastWorker.perform_async(party.current_song)
    if party.save
      session[:party_identifier] = party.identifier
      TrackBroadcastJob.perform_later(party.current_song.serialize_data) if party.current_song

    end
    redirect_to dashboard_path
  end

  def destroy
    party = current_user.parties.find(params[:id])
    party.destroy
    session[:party_identifier] = nil
    redirect_to dashboard_path
  end

  private
  def party_params
    params.require(:party).permit(:name)
  end

  # def serialized_data
  #   {
  #     id: party.current_song.id,
  #     name: party.current_song.name,
  #     artists: party.current_song.artists,
  #     album: party.current_song.album,
  #     image: party.current_song.image
  #   }
  #
  # end
end
