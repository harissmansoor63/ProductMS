class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception

	before_action :update_allowed_parameters, if: :devise_controller?

	protected

	def update_allowed_parameters
		added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
		devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
		devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)}
		devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:username, :first_name, :last_name, :email, :password, :current_password)}
		devise_parameter_sanitizer.permit :invite, keys: [:first_name, :last_name, :email]
	end
	
end
