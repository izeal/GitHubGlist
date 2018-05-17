class CommentsController < ApplicationController
  before_action :find_gist, only: [:create, :destroy, :edit, :update]
  before_action :find_comment, only: [:edit, :update, :destroy]
  # добавить проверку может ли юзер редактировать комментарии
  # сделать чтоб для не зареганнова пользователя не было видно форму комента
  # не отправлять себе письма если ты коммент у себя под гистом написал
  def create
    @comment = @gist.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to gist_path(@gist), notice: t('controllers.comments.created')
      GistMailer.comment(@comment).deliver_now
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
    #todo проверь чтоб комменты мог удалять и владелец гиста и автор коммента

    @comment.destroy!
    GistMailer.comment_destroyed(@comment).deliver_now
    redirect_to gist_path(@gist), notice: t('controllers.comments.destroyed')
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
