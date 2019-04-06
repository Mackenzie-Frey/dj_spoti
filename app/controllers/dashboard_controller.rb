class DashboardController < ApplicationController
  def index
    @users = current_party.users  if current_party
  end
end
