require 'rdiscount'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

private
  LINK_REGEXP = /<a href=['"]([^'^"]*)['"]>(.*)<\/a>/

  def twitter(nick)
      "<a href='https://twitter.com/#{nick}'><span class='symbol'>t</span>&nbsp;#{nick}</a>"
  end

  def pretty_link(link, text)
      uri = URI(link).normalize
      actual_text = if (link == text)
        "#{uri.host}#{uri.path}"
      else
        text
      end
      "<a class='url' href='#{link}'><img src='http://getfavicon.appspot.com/#{link}'> #{actual_text}</a>"
  end

  def markup(markdown)
      html = RDiscount.new(' ' + markdown).to_html
      with_pretty_links = html.gsub(LINK_REGEXP) { pretty_link($1, $2) }
      with_twitters = with_pretty_links.gsub(/@(\w*)/, twitter('\1'))
  end

  helper_method :markup
  helper_method :twitter
  helper_method :pretty_url

  def require_login
      if not current_user
          session[:return_to] = request.url
          redirect_to '/login'
      end
  end

  def current_user
    @_current_user ||= session[:current_auth_hash] &&
      User.find_by_auth_hash(session[:current_auth_hash])
  end

  def is_admin
    current_user.admin == true
  end
end
