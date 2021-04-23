class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: :show

  helper_method :sort_column, :sort_direction
  def index
    @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction).search(params[:search])
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

  def search_products
    if @product = Product.all.find{|product| product.title.include?(params[:search])}
      redirect_to product_path(@product)
    end
  end
end
