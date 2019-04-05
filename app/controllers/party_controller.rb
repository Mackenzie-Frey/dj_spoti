class PartyController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    binding.pry
    party = Party.new(party_params)
    party.admin = current_user
    party.users << current_user
    party.save
    redirect_to dashboard_path
  end

  private
  def party_params
    params.require(:party).permit(:name)
  end
end
