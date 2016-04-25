class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate
    logged_in? || access_denied
  end

  def logged_in?
    current_user.is_a? User
  end

  def access_denied
    flash[:notice] = "Please, log in"
    redirect_to root_url
    return false
  end

  protected :current_user
  helper_method :current_user, :logged_in?
end
