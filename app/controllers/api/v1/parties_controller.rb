class Api::V1::PartiesController < ApplicationController
  def show
    service = CurrentService.new(current_party)
    service.check_for_track_change
  end

end
