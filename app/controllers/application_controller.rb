class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #available to views
  helper_method :current_user, :logged_in?

  def current_user
    #optimization check if current user only if it isn't already retrieved
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #returns true if there is a current user
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end
end
