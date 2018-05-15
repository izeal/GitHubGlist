class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :config_params_for_create, if: :devise_controller?
  before_action :config_params_for_edit, if: :devise_controller?

  helper_method :current_user_can_edit?

  def config_params_for_edit
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end

  def config_params_for_create
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :password])
  end

  def current_user_can_edit?(model)
    user_signed_in? && (
      model.user == current_user || (
        model.try(:event) && model.event.user == current_user
      )
    )
  end
end
