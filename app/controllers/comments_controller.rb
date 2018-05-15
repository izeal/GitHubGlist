class CommentsController < ApplicationController
  before_action :find_gist, only: [:new, :create, :destroy, :edit, :update]

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
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "gist обновлен"
      redirect_to user_path(@gist.user)
    else
      flash[:danger] = "Текст ответа не может превышать
                        255 символов либо быть пустым"
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Ответ удален"
    redirect_to gist_path(@gist)
  end

  private

  def find_gist
    @gist = Gist.find(params[:gist_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
