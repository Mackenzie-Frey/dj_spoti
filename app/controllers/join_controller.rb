class JoinController < ApplicationController
  def show
    if session[:party_identifier]
      redirect_to dashboard_path, alert: "Please Leave The Current Party And Click The Invitation Link Again."
    else
      redirect_to spotify_omniauth_path(url: params[:i])
    end
  end

  private

  def send_invitation(phone_number, current_party)
    InvitationMailer.new.invite(phone_number, current_party)
  end
end
