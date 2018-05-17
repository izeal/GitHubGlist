class CommentsController < ApplicationController
  before_action :find_gist, only: [:create, :destroy, :edit, :update]
  before_action :find_comment, only: [:edit, :update, :destroy]


  def create
    @comment = @gist.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = t('controllers.comments.created')
      redirect_to gist_path(@gist)
    else
      flash[:danger] = t('controllers.comments.error')
      redirect_to gist_path(@gist)
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = t('controllers.comments.updated')
      redirect_to gist_path(@gist)
    else
      flash[:danger] = t('controllers.comments.error')
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = t('controllers.comments.destroyed')
    redirect_to gist_path(@gist)
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_gist
    @gist = Gist.find(params[:gist_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
