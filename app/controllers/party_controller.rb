class PartyController < ApplicationController
  def new
    @party = Party.new
  end

  def create
    party = Party.new(party_params)
    party.admin = current_user
    party.users << current_user
    party.save!
    # TrackBroadcastWorker.perform_async(party.current_song)

    redirect_to dashboard_path
  end

  private
  def party_params
    params.require(:party).permit(:name)
  end

end
