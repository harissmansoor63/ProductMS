class UsersController < ApplicationController
	before_action :getting_user

	def set_password; end

	def update_set_password
		if @user.update(user_password_params)
			redirect_to root_path
		else
			render :set_password
		end
	end

	private

	def user_password_params
		params.require(:user).permit(:password, :password_confirmation)
	end

	def getting_user
		@user = User.find(params[:id])
	end
end
