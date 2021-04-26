class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def set_password; end

  def update_set_password
    if @user.update(user_password_params)
      @user.update_column(:role, 0)
      redirect_to home_index_path
    else
      render :set_password
    end
  end

  def show; end

  def edit; end

  def update 
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank? # if password fields blanks
      @user.skip_validations = true #used to overide my vals
      if @user.update_without_password(user_params.except("current_password")) #used to overide devise vals
        redirect_to user_path
      else
        render 'edit'
      end
    else
      @user.skip_validations = false
      @user.skip_confirmation!
      if @user.update(user_params)
        redirect_to user_path
      else
        render 'edit'
      end
    end
  end

  private

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
