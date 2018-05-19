class UsersController < ApplicationController
  # before_action :check_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show] # дублирование колбэков
  before_action :set_current_user, except: [:show]

  def show
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('controllers.users.updated')
    else
      render :edit
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar)
  end

  def check_user
    reject_user unless current_user == @user
  end
end
