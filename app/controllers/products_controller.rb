class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: :show

  helper_method :sort_column, :sort_direction

  def index
    @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction).search(params[:search])
    @order_item = current_order.order_items.new
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def sort_column
    params[:sort] || "id"
  end

  def sort_direction
    params[:direction] || "asc"
  end
end
