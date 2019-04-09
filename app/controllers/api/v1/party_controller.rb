class Api::V1::PartyController < ApplicationController
  def show
    party = Party.find_by(identifier: params["identifier"])
    service = CurrentService.new(party)
    service.check_for_track_change
    # render :nothing => true
    render json: {
      message: "Job done!"
    }
  end

end
