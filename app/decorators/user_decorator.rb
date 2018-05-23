class UserDecorator
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def avatar
    @user.avatar? ? @user.avatar.url : ActionController::Base.helpers.asset_path('avatar.jpg')
  end

  def avatar_thumb
    @user.avatar? ? @user.avatar.thumb.url : ActionController::Base.helpers.asset_path('avatar_thumb.jpg')
  end
end
