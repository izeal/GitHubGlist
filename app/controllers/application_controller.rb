class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :config_params_for_create, if: :devise_controller?
  before_action :config_params_for_edit, if: :devise_controller?

  helper_method :current_user_can_edit?

  private

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
    current_user && model.user == current_user
  end

  def reject_user
    redirect_to root_path, alert: t('controllers.application.alert')
  end
end
