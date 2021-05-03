class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: :show

  helper_method :sort_column, :sort_direction

  def index
    @products = Product.search(params[:search]).page(params[:page]).per(Product::USER_PRODUCT_PERPAGE).order(sort_column + " " + sort_direction)
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
