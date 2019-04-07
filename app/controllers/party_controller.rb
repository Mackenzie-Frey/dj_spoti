class PartyController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    party = Party.new(party_params)
    party.identifier = SecureRandom.urlsafe_base64.to_s
    party.admin = current_user
    party.users << current_user
    if party.save
      session[:party_identifier] = party.identifier
    end
    redirect_to dashboard_path
  end

  def destroy
    party = current_user.parties.find(params[:id])
    party.destroy
    redirect_to dashboard_path
  end

  private
  def party_params
    params.require(:party).permit(:name)
  end
end
