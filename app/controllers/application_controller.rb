require 'rdiscount'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

private
  def twitter(nick)
      "<a href='https://twitter.com/#{nick}'><span class='symbol'>t</span>&nbsp;#{nick}</a>"
  end

  def markup(markdown)
      html = RDiscount.new(markdown).to_html
      with_twitters = html.gsub(/@(\w*)/, twitter('\1'))
      with_twitters 
  end

  helper_method :markup
  helper_method :twitter

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
