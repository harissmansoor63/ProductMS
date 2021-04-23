class Users::InvitationsController < Devise::InvitationsController

  # after_create :rolechanger 


  def update
    User.accept_invitation!(update_resource_params)
       # @user = User.find(params[:id])
       # @user.update(role: 2)
  end

   def new
    self.resource = resource_class.new
    render :new
  end

 def create
    byebug
    super
    # self.resource = invite_resource
    # resource_invited = resource.errors.empty?
    # byebug
    # yield resource if block_given?
    # if resource_invited
    #   if is_flashing_format? && self.resource.invitation_sent_at
    #     # byebug
    #     # @user = resource_invited
        
    #     set_flash_message :notice, :send_instructions, email: self.resource.email
    #     self.resource.update_column(:role, 2) 
    #   end
    #   if self.method(:after_invite_path_for).arity == 1
    #     respond_with resource, location: after_invite_path_for(current_inviter)
    #   else
    #     respond_with resource, location: after_invite_path_for(current_inviter, resource)
    #   end
    # else
    #   respond_with_navigational(resource) { render :new }
    # end
  end

  private

  # This is called when creating invitation.
  # It should return an instance of resource class.
  def invite_resource
    # skip sending emails on invite
    super { |user| user.skip_invitation = true }     
  end

  # This is called when accepting invitation.
  # It should return an instance of resource class.
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    # Report accepting invitation to analytics
    Analytics.report('invite.accept', resource.id)
    resource
  end

  
    # def rolechanger
    #   @user = User.find(params[:id])
    #   @user.create(role: 2)
    # end
end
