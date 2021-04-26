class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:username, :first_name, :last_name, :email, :password, :current_password)}
    devise_parameter_sanitizer.permit :invite, keys: [:first_name, :last_name, :email, :role]
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_products_path
    elsif current_user.invited_user?
      set_password_path(current_user.id)
    else
      root_path
    end
  end
end
