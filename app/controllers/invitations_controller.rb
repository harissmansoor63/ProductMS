class InvitationsController < Devise::InvitationsController
  def new
    super
  end
  
  def create
    super
  end

  def invite_params
    devise_parameter_sanitizer.sanitize(:invite).with_defaults(role: 2)
  end
end
