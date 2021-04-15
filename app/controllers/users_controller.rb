class UsersController < ApplicationController

	def set_password
		@user = User.find(params[:id])
	end

	def update_set_password
		@user = User.find(params[:id])
		#byebug
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
end
