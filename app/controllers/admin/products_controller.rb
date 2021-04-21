class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
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
    params.require(:product).permit(:title, :price, :description, :status)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
