# frozen_string_literal: true

# All controller inherit from ApplicationController
class ApplicationController < ActionController::Base
  # include SessionsHelper

  helper_method :current_user,
                :current_party,
                :require_user!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_party
    @current_party ||= Party.find_by(identifier: session[:party_identifier]) if session[:party_identifier]
  end

  def require_user!
    four_oh_four unless current_user
  end

  def four_oh_four
    raise ActionController::RoutingError.new('Not Found')
  end

end
