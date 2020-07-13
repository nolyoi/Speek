# frozen_string_literal: true

class SessionsController < ApplicationController

  def new
    if current_user
      flash[:info] = "You are already logged in as #{current_user.email}!"
      redirect_to root_path
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
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id

    redirect_to root_path, :success => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end
