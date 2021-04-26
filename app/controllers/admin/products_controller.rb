class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction
  def index
    @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction).search(params[:search])
    @products_download = Product.all
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"product-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def new
     @product = Product.new
  end

  def show; end

  def edit; end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render 'new'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :description, :status, :image)
  end

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
