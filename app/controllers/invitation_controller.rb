class InvitationController < ApplicationController
  def create
    phone_number = params[:ph_number]
    if phone_number
      send_invitation(phone_number, current_party)
    else
      flash[:error] = 'Inviation could not be sent!!'
    end
  end


  private
  def send_invitation(phone_number, current_party)
    InvitationMailer.new.invite(phone_number, current_party)
  end
end
