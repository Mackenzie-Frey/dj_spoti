class JoinController < ApplicationController
  def show
    redirect_to spotify_omniauth_path(url: params[:i])
  end


  private
  def send_invitation(phone_number, current_party)
    InvitationMailer.new.invite(phone_number, current_party)
  end
end
