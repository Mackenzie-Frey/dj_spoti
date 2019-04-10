class JoinController < ApplicationController
  def show
    if session[:party_identifier]
      if !Party.find_by(identifier: session[:party_identifier])
        session[:party_identifier] = nil
        redirect_to spotify_omniauth_path(url: params[:i])
      else
      end
    else
      redirect_to spotify_omniauth_path(url: params[:i])
    end
  end

  private
  def send_invitation(phone_number, current_party)
    InvitationMailer.new.invite(phone_number, current_party)
  end
end
