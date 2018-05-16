class CommentsController < ApplicationController
  before_action :find_gist, only: [:new, :create, :destroy, :edit, :update]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def new
    @comment = @gist.comments.build
  end

  def create
    @comment = @gist.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Комментарий написан"
      redirect_to gist_path(@gist)
    else
      flash[:danger] = "Текст комментария не может превышать
                        255 символов либо быть пустым"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "comment обновлен"
      redirect_to gist_path(@gist)
    else
      flash[:danger] = "Текст commenta не может превышать
                        255 символов либо быть пустым"
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "comment удален"
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
