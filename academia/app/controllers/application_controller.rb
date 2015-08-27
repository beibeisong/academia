class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by_authentication_token(cookies[:auth_token]) if (cookies[:auth_token])

    @current_user
  end
  
  protected

  def authenticate_user
    session[:user_id].present?()
  end

  def validate_logged_in
    forbidden() unless current_user
  end

  def validate_write_permissions
    unauthorized() unless has_permission?('write')
  end

  def validate_read_permissions
    unauthorized() unless has_permission?('read')
  end

  def save_login_state
    !session[:user_id].present?()
  end
  
end
