class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def set_subtotal(coupon = Coupon.new)
    self.subtotal = sub_total(coupon)
  end

  def sub_total(coupon)
    order_items.collect {|order_item|
      if order_item.valid?
        if (order_item.product.coupons.ids).include? coupon.id
          price_with_coupon = order_item.unit_price
          price_with_coupon = price_with_coupon - (price_with_coupon * (Float(coupon.discount)/100))
          price_with_coupon * order_item.quantity
        else
          order_item.unit_price * order_item.quantity
        end
      else
        0
      end
      }.sum
  end
end
