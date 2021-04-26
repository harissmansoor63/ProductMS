class InvitationsController < Devise::InvitationsController
  def new
    super
  end
  
  def create
    super
    @user = User.find_by(email: params[:user][:email])
    @user.update_column(:role, 2)
  end
end
