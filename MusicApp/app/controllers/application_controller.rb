class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def current_user
    @current_user
  end 

  def login(user)
   session[:session_token] = user.reset_session_token!
   @current_user = user
  end

end
