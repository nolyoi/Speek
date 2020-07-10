# frozen_string_literal: true

class SessionsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:omni]

  def new
    if current_user
      flash[:info] = "You are already logged in as #{current_user.email}!"
      redirect_to root_path
    else
      render layout: false
    end
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_dashboard_path, { success: "Welcome back to Speek, #{current_user.username}!" }
    else
      redirect_to root_path, { alert: 'Your Username or Password was invalid' }
    end
  end

  def omni
    @user = User.find_or_create_by(uid: auth[:uid]) do |u|
      u.name = auth[:info][:name]
      u.uid = auth[:uid]
    end

    pp request.env['omniauth.auth']
    session[:user_id] = @user.id

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
