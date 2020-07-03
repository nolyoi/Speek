class UsersController < ApplicationController
  include ApplicationHelper
  include UsersHelper
  load_and_authorize_resource param_method: :user_params

  def index
    @users = User.all
  end
  
  def clear
    clear_session(:search_name, :filter_name, :filter)
    redirect_to users_path
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Use successfully created"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:danger] = "Something went wrong. Please try again."

      render new_user_path
    end
    authorize! :create, @user
  end

  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "User was successfully updated"
        redirect_to @user
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
      authorize! :update, @user
  end 
  
  def destroy
    authorize! :destroy, User.find(params[:id])
    if destroy_user_data(params[:id], what: "all")
      flash[:success] = 'Your account, shops, and invites were successfully deleted.'
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to users_url
    end
  end

  def dashboard
    
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation, :bio, :twitter_url, :facebook_url, :website_url, :avatar)
  end
end