class PartyUsersController < ApplicationController
  def destroy
    current_user.update_attribute(:party_id, nil)
    session[:party_identifier] = nil
    redirect_to dashboard_path
  end
end
