class RelationshipsController < ApplicationController
  before_action :check_current_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    redirect_to @user, notice: t('controllers.relationships.created')
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    redirect_to @user, notice: t('controllers.relationships.destroyed')
  end

  private

  def check_current_user
    return unless current_user
  end
end
