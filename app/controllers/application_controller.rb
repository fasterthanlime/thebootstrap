require 'rdiscount'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

private
  # this is pretty much as hackish as it gets
  URL_REGEXP = /[^"^'^>]((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/[^ ^<]*)?)/
  URL_TAG_REGEXP = /<(\w*)>((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/[^ ^<]*)?)/
  LINK_REGEXP = /<a href=['"](.*)['"]>(.*)<\/a>/

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
      with_twitters = html.gsub(/@(\w*)/, twitter('\1'))
      with_implicit_links = with_twitters.gsub(URL_REGEXP, ' <a href="\1">\1</a>') \
                                         .gsub(URL_TAG_REGEXP, ' <\1><a href="\2">\2</a>')
      with_pretty_links = with_implicit_links.gsub(LINK_REGEXP) { pretty_link($1, $2) }
  end

  helper_method :markup
  helper_method :twitter
  helper_method :pretty_url

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
