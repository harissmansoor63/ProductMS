class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def set_password; end

  def update_set_password
    if @user.update(user_password_params)
      @user.user!
      redirect_to home_index_path
    else
      render :set_password
    end
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

  private

  def update_skip_validations
    @user.skip_validations = true #used to overide my vals
    if @user.update_without_password(user_params.except(:current_password)) #used to overide devise vals
      render 'show'
    else
      render 'edit'
    end
  end

  def update_allow_validations
    @user.skip_validations = false
    @user.skip_confirmation!
    if @user.update(user_params)
      render 'show'
    else
      render 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :password_confirmation)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
