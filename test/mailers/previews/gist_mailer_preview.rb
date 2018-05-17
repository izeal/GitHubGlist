# Preview all emails at http://localhost:3000/rails/mailers/gist_mailer
class GistMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/gist_mailer/comment
  def comment
    GistMailer.comment
  end

end
