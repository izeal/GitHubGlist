module ApplicationHelper
  def errors_viewer(resource)
    return nil if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <p>#{sentence}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def full_title(title = '')
    base_title = 'GitHubGlist'
    title == '' ? base_title : "#{title} | #{base_title}"
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def user_avatar(user)
    user.avatar? ? user.avatar.url : asset_path('avatar.jpg')
  end

  def user_avatar_thumb(user)
    user.avatar? ? user.avatar.thumb.url : asset_path('avatar_thumb.jpg')
  end

  def user_voted_for?(gist)
    current_user == gist.stars.find_by(user_id: current_user.id).try(:user)
  end
end
