class CommentsController < ApplicationController
  before_action :find_gist, only: [:create, :destroy, :edit, :update]
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update]
  before_action :check_user_to_destroy, only: [:destroy]

  def create
    @comment = @gist.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to gist_path(@gist), notice: t('controllers.comments.created')
      GistMailer.comment(@comment).deliver_now unless current_user == @gist.user
    else
      redirect_to gist_path(@gist), alert: t('controllers.comments.error')
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to gist_path(@gist), notice: t('controllers.comments.updated')
    else
      render 'edit', alert: t('controllers.comments.error')
    end
  end

  def destroy
    @comment.destroy!
    GistMailer.comment_destroyed(@comment).deliver_now unless current_user == @gist.user
    redirect_to gist_path(@gist), notice: t('controllers.comments.destroyed')
  end

  private

  def find_comment
    @comment = Comment.find_by(id: params[:id])
    reject_user if @comment.blank?
  end

  def find_gist
    @gist = Gist.find(params[:gist_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def check_user
    reject_user unless current_user == @comment.user
  end

  def check_user_to_destroy
    reject_user unless current_user == @comment.user || current_user == @gist.user
  end
end
