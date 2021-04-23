class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.staff
  end

  def show; end

  def edit; end

  def update
      if params[:password].blank? # this check needs to be correct somehow
          @user.skip_validations = true  # used to overide my vals
          if @user.update_without_password(user_params.except("current_password")) # used to overide devise vals
            redirect_to admin_users_path
          else
            render 'edit'
          end
      else
          @user.skip_validations = false
          if @user.update(user_params)
            redirect_to admin_users_path
          else
            render 'edit'
          end
      end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def role_setter
    @user.role = 2
  end

end
