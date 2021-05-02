class Admin::CouponsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  def index
    @coupons = Coupon.page(params[:page]).per(10).order(sort_column + " " + sort_direction).search(params[:search])
    @coupons_download = Coupon.all
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"coupon-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def new
   @coupon = Coupon.new
   @products = Product.all
  end

  def show; end

  def edit; end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to admin_coupons_path
    else
      render 'new'
    end
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_path
    else
      render 'edit'
    end
  end

  def destroy
    @coupon.destroy
    redirect_to admin_coupons_path
  end

  private

  def coupon_params
    params.require(:coupon).permit(:title, :discount, product_ids:[])
  end

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def sort_column
    params[:sort] || "id"
  end

  def sort_direction
    params[:direction] || "asc"
  end
end
