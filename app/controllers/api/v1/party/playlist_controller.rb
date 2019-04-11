class Api::V1::Party::PlaylistController < ApplicationController
  def show
    render json: current_party.playlist_tracks
  end
end
