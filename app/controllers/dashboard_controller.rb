class DashboardController < ApplicationController
  def index
    render locals: {
      facade: SongFacade.new(current_user)
    }
    @users = current_party.users  if current_party
  end
end
