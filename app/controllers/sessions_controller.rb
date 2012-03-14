require 'hashie'

class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    p current_user
    if current_user
      redirect_to :root
      return
    end
  end

  def create
    omni = Hashie::Mash.new request.env['omniauth.auth']

    nick = omni.info.nickname
    @user = User.find_or_create_by_auth_hash_and_nick(omni.uid, nick)
    @user.update_credentials!(omni.credentials)

    session[:current_auth_hash] = @user.auth_hash

    if @user.new_record?
      redirect_to '/pages/welcome'
    else
      redirect_to :root
    end
  end

  def destroy
    session[:current_auth_hash] = ''
    redirect_to :root
  end
end
