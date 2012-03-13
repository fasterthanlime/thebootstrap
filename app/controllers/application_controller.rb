class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

private

  def require_login
      redirect_to '/login' if not current_user
  end

  def current_user
    @_current_user ||= session[:current_auth_hash] &&
      User.find_by_auth_hash(session[:current_auth_hash])
  end
end
