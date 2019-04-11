class PartyController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    party = Party.new(party_params)
    party.identifier = SecureRandom.urlsafe_base64.to_s
    party.admin = current_user
    # TrackBroadcastWorker.perform_async(party.current_song)
    if party.save
      current_user.update_attribute(:party_id, party.id)
      session[:party_identifier] = party.identifier
      new_playlist(party)
      party.current_song
      # TrackBroadcastJob.perform_later(party.current_song.serialize_data) if party.current_song
    end
    redirect_to dashboard_path
  end

  def destroy
    party = Party.find(current_user.party_id)
    if current_user == current_party.admin
      User.where(party_id: party.id).update_all(party_id: nil)
    else
      current_user.update_attribute(:party_id, nil)
    end
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
