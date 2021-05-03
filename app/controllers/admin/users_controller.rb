class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.staff
  end

  def show; end

  def edit; end

  def update 
    if user_params[:password].blank? && user_params[:password_confirmation].blank? # if password fields blanks
      update_skip_validations
    else
      update_allow_validations
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def update_skip_validations
    @user.skip_validations = true #used to overide my vals
    if @user.update_without_password(user_params.except(:current_password)) #used to overide devise vals
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def update_allow_validations
    @user.skip_validations = false
    @user.skip_confirmation!
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end


  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
