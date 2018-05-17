class GistMailer < ApplicationMailer
  def comment(comment)
    @comment = comment
    @gist = @comment.gist

    mail to: @gist.user.email, subject: "Новый комментарий для #{@gist.description}"
  end

  def comment_destroyed(comment)
    @comment = comment
    @gist = @comment.gist

    mail to: @gist.user.email, subject: "Комментарий для #{@gist.description} удален"
  end
end
