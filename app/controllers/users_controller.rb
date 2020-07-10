class UsersController < ApplicationController
  include ApplicationHelper
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follow, :unfollow]
  load_and_authorize_resource param_method: :user_params

  def index
    @users = User.all.paginate(page: params[:page], per_page: 30)
  end

  def show; end

  def dashboard; end

  def edit; authorize! :edit, @user end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'User was successfully updated'
      redirect_to @user
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
    authorize! :update, @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Use successfully created'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:danger] = 'Something went wrong. Please try again.'

      render new_user_path
    end
    authorize! :create, @user
  end

  def destroy
    authorize! :destroy, User.find(params[:id])
    if destroy_user_data(params[:id], what: 'all')
      flash[:success] = 'Your account, shops, and invites were successfully deleted.'
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to users_url
    end
  end

  def follow 
    @follow = current_user.follows_given.new(following_id: params[:user_id])
    if @follow.save
      flash[:success] = "You are now following #{@user.username}"
      redirect_to user_path(@user)
    else
      flash[:danger] = 'Something went wrong. Please try again.'
      redirect_to user_path(@user)
    end
  end

  def unfollow 
    @follow = current_user.follows_given.find_by(following_id: params[:user_id])
    if @follow.destroy
      flash[:success] = "You have unfollowed #{@user.username}."
      redirect_to user_path(@user)
    else
      flash[:danger] = 'Something went wrong. Please try again.'
      redirect_to user_path(@user)
    end
  end

  private

  def set_user
    if params[:user_id]
      @user = User.find(params[:user_id]) 
    else
      @user = User.find(params[:id]) 
    end
  end

  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation, :bio, :twitter_url, :facebook_url, :website_url, :avatar)
  end
end
