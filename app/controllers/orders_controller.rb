class OrdersController < ApplicationController
  before_action :set_order
  
  def new
    @order_items = @order.order_items
  end

  def confirmation
    @order.confirmation = true
    @order.set_subtotal(Coupon.find(params[:id][:coupon_id]))
    if @order.update(order_params)
      redirect_to show_confirmation_path
    else
      render 'edit'
    end
  end

  def show_confirmation; end

  private

  def set_order
    @order = current_order
  end

  def order_params
    params.require(:order).permit(:address, :coupon_id, :subtotal)
  end
end
