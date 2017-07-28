class SessionsController < ApplicationController

  def create
    user = User.find_by_creds(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
    else
      login(user)
      redirect_to user_url
    end
  end

  def login(user)
    @current_user = user
    session[:session_token] = user.reset_token!
  end

  def destroy

  end

end
