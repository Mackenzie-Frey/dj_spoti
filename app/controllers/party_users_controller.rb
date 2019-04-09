class PartyUsersController < ApplicationController
  def destroy
    current_user.parties.delete(current_party)
    session[:party_identifier] = nil
    redirect_to dashboard_path
  end
end
