class SongSearchController < ApplicationController
  def index
    @facade = SongSearchFacade.new(params['song_name'], current_user)
  end
end
