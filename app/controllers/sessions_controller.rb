class SessionsController < Devise::SessionsController
  def destroy
    if current_user.user? && @order = Order.find_by_id(session[:order_id])
      @order.destroy unless @order.confirmation   
    end
    super
  end
end
