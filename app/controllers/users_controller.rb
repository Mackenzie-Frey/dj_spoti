# frozen_string_literal: true

# Controller for the Users
class UsersController < ApplicationController
  def create
    @user = User.new(spotify_params(request.env['omniauth.auth']))
    check_user_registration(@user)
    redirect_to root_path
  end

  private

  def spotify_params(auth_hash)
    spotify_info = {}
    spotify_info[:name] = auth_hash.info[:name]
    spotify_info[:spotify_id] = auth_hash.uid
    spotify_info[:access_token] = auth_hash.credentials.token
    spotify_info[:refresh_token] = auth_hash.credentials.refresh_token
    spotify_info
  end

  def check_user_registration(user)
    if user.save
      flash[:success] = 'You have successfully registered an account'
      session[:user_id] = user.id
    else
      flash[:error] = user.errors.full_messages.to_sentence
    end
  end
end
