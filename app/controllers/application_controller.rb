require 'rdiscount'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

private

  def markup(markdown)
      with_twitters = markdown.gsub(/@(\w*)/, '[@\1](https://twitter.com/\1)')
      RDiscount.new(with_twitters).to_html
  end
  helper_method :markup

  def require_login
      redirect_to '/login' if not current_user
  end

  def current_user
    @_current_user ||= session[:current_auth_hash] &&
      User.find_by_auth_hash(session[:current_auth_hash])
  end

  def is_admin
    current_user.admin == true
  end
end
