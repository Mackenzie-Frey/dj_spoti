class InvitationController < ApplicationController
  def create
    phone_number = params[:ph_number]
    if phone_number
      send_invitation(phone_number)
    else
      flash[:error] = 'Inviation could not be sent!!'
    end
  end


  private
  def send_invitation

  end
end
