# frozen_string_literal: true

# All controller inherit from ApplicationController
class ApplicationController < ActionController::Base
  helper_method :current_user,
                :current_party

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_party
    @current_party ||= Party.find_by(identifier: session[:party_identifier]) if session[:party_identifier]
  end

  def new_playlist(party)
    Playlist.new(party).aggregated_top_play_ids
  end
end
