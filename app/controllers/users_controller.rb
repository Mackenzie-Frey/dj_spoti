class UsersController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    
    spotify_info = Hash.new
    spotify_info[:name] = auth.info[:name]
    spotify_info[:spotify_id] = auth.uid
    spotify_info[:access_token] = auth.credentials.token
    spotify_info[:refresh_token] = auth.credentials.refresh_token

    @user = User.new(spotify_info)

    if @user.save
      flash[:success] = "You have successfully registered an account"
      session[:user_id] = @user.id
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end
end
