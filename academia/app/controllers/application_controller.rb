class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  
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

  ##    Forbidden
  #   Return: Error with status :forbidden (403).
  def forbidden
    render(
        nothing: true,
        status: :forbidden
    )
  end

  ##    Unauthorized
  #   Returns: Error with status :unauthorized (401).
  def unauthorized
    render(
        nothing: true,
        status: :unauthorized
    )
  end
  
end
