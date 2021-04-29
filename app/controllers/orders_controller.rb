class OrdersController < ApplicationController
  before_action :set_order
  
  def show; end

  def confirm
    @order.confirmation = true
    @order.save
  end

  private

  def set_order
    @order = current_order
  end
end
