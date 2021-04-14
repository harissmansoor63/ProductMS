class Admin::UsersController < ApplicationController

	before_action :authenticate_user!

	def index
		@users= User.where(role: User.roles[:user])
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :password, :username, :email)
	end

end
