class InvitationController < ApplicationController
  def create
    params.each do |key, value|
      begin
        send_invitation(value, current_party) if key.start_with?("ph_number")
      rescue
        flash[:error] = "Inviation could not be sent to `#{value}`.Please Make sure its a valid number."
      end
    end
    redirect_to dashboard_path
  end


  private
  def send_invitation(phone_number, current_party)
    InvitationMailer.new.invite(phone_number, current_party)
  end
end
