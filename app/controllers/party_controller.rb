class PartyController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    party = Party.new(party_params)
    party.admin_id = current_user.id
    party.save
    redirect_to dashboard_path
  end

  private
  def party_params
    params.require(:party).permit(:name)
  end
end
