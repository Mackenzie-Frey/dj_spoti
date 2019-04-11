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
    invite_people(params)
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

  def invite_people(params)
    params.each do |key, value|
      begin
        send_invitation(value, current_party) if key.start_with?("ph_number")
      rescue
        flash[:error] = "Inviation could not be sent to #{value}.Please Make sure its a valid number."
      end
    end
  end

  def send_invitation(phone_number, current_party)
    InvitationMailer.new.invite(phone_number, current_party)
  end
end
