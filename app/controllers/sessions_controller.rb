class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => %w(new create)

  def new
  end

  def create
    nickname = request.env['omniauth.auth']['info']['nickname']
    @user = User.find_or_create_by_auth_hash_and_nick(auth_hash, nickname)

    session[:current_auth_hash] = @user.auth_hash
    redirect_to :root
  end

private

  def auth_hash
    "#{request.env['omniauth.auth']['uid']}"
  end
end
